import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/auth/screens/SignInScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    setStatusBarColor(Colors.transparent);
    await 3.seconds.delay;
    finish(context);
    SignInScreen().launch(context, isNewTask: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'images/tumy/svSplashImage.jpg',
            height: context.height(),
            width: context.width(),
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/tumy/svAppIcon.png',
                  height: 50,
                  width: 52,
                  fit: BoxFit.cover,
                  color: Colors.white),
              8.width,
              Text("tumy",
                  style: primaryTextStyle(
                      color: Colors.white, size: 40, weight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }
}
