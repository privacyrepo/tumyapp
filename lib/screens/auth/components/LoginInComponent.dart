import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/screens/DashboardScreen.dart';
import 'package:tumy_app/screens/auth/screens/ForgetPasswordScreen.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';

class LoginInComponent extends StatefulWidget {
  final VoidCallback? callback;

  LoginInComponent({this.callback});

  @override
  State<LoginInComponent> createState() => _LoginInComponentState();
}

class _LoginInComponentState extends State<LoginInComponent> {
  bool doRemember = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      color: context.cardColor,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.height,
            Text('Welcome back!', style: boldTextStyle(size: 24))
                .paddingSymmetric(horizontal: 16),
            8.height,
            Text('You Have Been Missed For Long Time',
                    style: secondaryTextStyle(
                        weight: FontWeight.w500, color: svGetBodyColor()))
                .paddingSymmetric(horizontal: 16),
            Container(
              child: Column(
                children: [
                  30.height,
                  AppTextField(
                    textFieldType: TextFieldType.EMAIL,
                    textStyle: boldTextStyle(),
                    decoration: svInputDecoration(
                      context,
                      label: 'Username',
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  16.height,
                  AppTextField(
                    textFieldType: TextFieldType.PASSWORD,
                    textStyle: boldTextStyle(),
                    suffixIconColor: svGetBodyColor(),
                    suffixPasswordInvisibleWidget: Image.asset(
                            'images/tumy/icons/ic_Hide.png',
                            height: 16,
                            width: 16,
                            fit: BoxFit.fill)
                        .paddingSymmetric(vertical: 16, horizontal: 14),
                    suffixPasswordVisibleWidget:
                        svRobotoText(text: 'Show', color: AppColorPrimary)
                            .paddingOnly(top: 20),
                    decoration: svInputDecoration(
                      context,
                      label: 'Password',
                      contentPadding: EdgeInsets.all(0),
                      labelStyle: secondaryTextStyle(
                          weight: FontWeight.w600, color: svGetBodyColor()),
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  12.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            shape:
                                RoundedRectangleBorder(borderRadius: radius(2)),
                            activeColor: AppColorPrimary,
                            value: doRemember,
                            onChanged: (val) {
                              doRemember = val.validate();
                              setState(() {});
                            },
                          ),
                          svRobotoText(text: 'Remember Me'),
                        ],
                      ),
                      svRobotoText(
                        text: 'Forget Password?',
                        color: AppColorPrimary,
                        fontStyle: FontStyle.italic,
                        onTap: () {
                          ForgetPasswordScreen().launch(context);
                        },
                      ).paddingSymmetric(horizontal: 16),
                    ],
                  ),
                  32.height,
                  svAppButton(
                    context: context,
                    text: 'LOGIN',
                    onTap: () {
                      DashboardScreen().launch(context);
                    },
                  ),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      svRobotoText(text: 'Don’t Have An Account?'),
                      4.width,
                      Text(
                        'Sign Up',
                        style: secondaryTextStyle(
                            color: AppColorPrimary,
                            decoration: TextDecoration.underline),
                      ).onTap(() {
                        widget.callback?.call();
                      },
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent)
                    ],
                  ),
                  50.height,
                  svRobotoText(text: 'OR Continue With'),
                  16.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('images/tumy/icons/ic_Google.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                      8.width,
                      Image.asset('images/tumy/icons/ic_Facebook.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                      8.width,
                      Image.asset('images/tumy/icons/ic_Twitter.png',
                          height: 36, width: 36, fit: BoxFit.cover),
                    ],
                  ),
                  50.height,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
