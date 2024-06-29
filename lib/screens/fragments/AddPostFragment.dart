import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/addPost/components/PostOptionsComponent.dart';
import 'package:tumy_app/screens/addPost/components/PostTextComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/firebase/models/FirestoreService.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image; 
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'package:uuid/uuid.dart';

class AddPostFragment extends StatefulWidget {
  const AddPostFragment({Key? key}) : super(key: key);

  @override
  State<AddPostFragment> createState() => _AddPostFragmentState();
}

class _AddPostFragmentState extends State<AddPostFragment> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final Uuid uuid = Uuid();
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() {
      setStatusBarColor(context.cardColor);
    });
  }

  @override
  void dispose() {
    setStatusBarColor(
        appStore.isDarkMode ? appBackgroundColorDark : AppLayoutBackground);
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _createPost() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final currentUser = authProvider.currentUser;

    if (currentUser == null) {
      toast('Please log in to create a post');
      return;
    }

    if (_titleController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty) {
      toast('Title and description cannot be empty');
      return;
    }

    String postId = uuid.v4();
    Post newPost = Post(
      id: postId,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      authorId: currentUser.id,
      images: _imageUrls,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _firestoreService.createPost(newPost);
    toast('Post created successfully');
    Navigator.of(context).pop(); // Close the screen after posting
  }

  Future<void> _uploadImages(List<File> imageFiles) async {
    for (File imageFile in imageFiles) {
      String fileName = uuid.v4();
      UploadTask uploadTask =
          _firebaseStorage.ref().child('post_images/$fileName').putFile(imageFile);

      try {
        TaskSnapshot taskSnapshot = await uploadTask;
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        setState(() {
          _imageUrls.add(downloadUrl);
        });
      } catch (e) {
        print("Error uploading image: $e");
        // Handle error as needed
      }
    }
  }

  void _onImagesSelected(List<File> selectedImages) async {
    await _uploadImages(selectedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: context.iconColor),
        backgroundColor: context.cardColor,
        title: Text('New Post', style: boldTextStyle(size: 20)),
        elevation: 0,
        centerTitle: true,
        actions: [
          AppButton(
            shapeBorder: RoundedRectangleBorder(borderRadius: radius(4)),
            text: 'Post',
            textStyle: secondaryTextStyle(color: Colors.white, size: 10),
            onTap: _createPost,
            elevation: 0,
            color: AppColorPrimary,
            width: 50,
            padding: EdgeInsets.all(0),
          ).paddingAll(16),
        ],
      ),
      body: SizedBox(
        height: context.height(),
        child: Stack(
          children: [
            PostTextComponent(
              titleController: _titleController,
              descriptionController: _descriptionController,
            ),
            Positioned(
              child: PostOptionsComponent(
                onImagesSelected: _onImagesSelected,
              ),
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
