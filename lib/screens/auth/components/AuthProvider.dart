import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  bool _isLoggedIn = false;

  User? get currentUser => _currentUser;
  bool get isLoggedIn => _isLoggedIn;

  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthProvider() {
    _loadUserFromPreferences();
    _auth.authStateChanges().listen((firebase_auth.User? firebaseUser) {
      if (firebaseUser != null) {
        _loadUserFromFirestore(firebaseUser.uid);
      } else {
        _currentUser = null;
        _isLoggedIn = false;
        notifyListeners();
      }
    });
  }

  String? getCurrentUserId() {
    return _auth.currentUser?.uid;
  }

  Future<void> login(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      firebase_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        await _loadUserFromFirestore(firebaseUser.uid);
        _isLoggedIn = true;
        _saveUserToPreferences();
        notifyListeners();
      }
    } catch (e) {
      print("Login failed: $e");
      throw e;
    }
  }

  Future<void> signUp(String email, String password) async {
    try {
      firebase_auth.UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser == null) return;

      String name = 'user' + firebaseUser.uid.substring(0, 5);
      _currentUser = User(
        id: firebaseUser.uid,
        email: email,
        password: password, // Avoid storing plain text passwords
        name: name,
        bio: '',
        avatar: 'https://img.icons8.com/?size=100&id=492ILERveW8G&format=png&color=000000',
        role: 'USER',
        followers: [],
        following: [],
        messagesSent: [],
        messagesReceived: [],
        notifications: [],
        savedPosts: [],
        payments: [],
        referrals: [],
        referredUsers: [],
        pregnancyProgress: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(firebaseUser.uid).set(_currentUser!.toFirestore());
      _isLoggedIn = true;
      _saveUserToPreferences();
      notifyListeners();
    } catch (e) {
      print("Sign up failed: $e");
      throw e;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _currentUser = null;
    _isLoggedIn = false;
    _removeUserFromPreferences();
    notifyListeners();
  }

  Future<void> _loadUserFromFirestore(String uid) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();
      if (userDoc.exists) {
        _currentUser = User.fromFirestore(userDoc);
        _isLoggedIn = true;
        _saveUserToPreferences();
        notifyListeners();
      }
    } catch (e) {
      print("Failed to load user from Firestore: $e");
    }
  }

  Future<void> _saveUserToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (_currentUser != null) {
      prefs.setString('user', jsonEncode(_currentUser!.toMap()));
      prefs.setBool('isLoggedIn', _isLoggedIn);
    }
  }

  Future<void> _loadUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isLoggedIn') ?? false) {
      String? userData = prefs.getString('user');
      if (userData != null) {
        _currentUser = User.fromMap(jsonDecode(userData));
        _isLoggedIn = true;
        notifyListeners();
      }
    }
  }

  Future<void> _removeUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
    prefs.setBool('isLoggedIn', false);
  }
}
