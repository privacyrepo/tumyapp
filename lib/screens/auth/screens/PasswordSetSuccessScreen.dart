import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';

class PasswordSetSuccessScreen extends StatelessWidget {
  const PasswordSetSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.cardColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              100.height,
              Image.asset('images/tumy/gifs/success_tickmark.gif',
                      fit: BoxFit.cover)
                  .paddingOnly(left: 30, right: 30),
              Text('Your Password Reset Was', style: boldTextStyle(size: 24)),
              Text('Successfully!',
                  style: boldTextStyle(size: 24, color: Color(0xFF00A66C))),
            ],
          ),
          svAppButton(
            context: context,
            text: 'DONE',
            onTap: () {
              finish(context);
              finish(context);
              finish(context);
              finish(context);
            },
          ).paddingSymmetric(vertical: 20),
        ],
      ),
    );
  }
}
