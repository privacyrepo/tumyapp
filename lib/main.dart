import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tumy_app/screens/SplashScreen.dart';
import 'package:tumy_app/store/AppStore.dart';
import 'package:tumy_app/utils/AppTheme.dart';
import 'package:tumy_app/screens/auth/components/AuthProvider.dart';
import 'package:tumy_app/screens/DashboardScreen.dart';
import 'package:tumy_app/screens/auth/screens/SignInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:tumy_app/firebase/models/DummyData.dart';
AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();
  appStore.toggleDarkMode(value: false);
  // await addDummyData(5, 5, 15);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: Observer(
        builder: (_) => MaterialApp(
          scrollBehavior: SBehavior(),
          navigatorKey: navigatorKey,
          title: 'tumy',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Consumer<AuthProvider>(
            builder: (context, auth, _) {
              return auth.isLoggedIn ? DashboardScreen() : SignInScreen();
            },
          ),
        ),
      ),
    );
  }
}
