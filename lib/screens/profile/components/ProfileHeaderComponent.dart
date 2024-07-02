import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Constants.dart';

class ProfileHeaderComponent extends StatelessWidget {
  const ProfileHeaderComponent(String? avatar, {Key? key}) : super(key: key);
  
  String? get avatar => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(
                'images/tumy/backgroundImage.png',
                width: context.width(),
                height: 130,
                fit: BoxFit.cover,
              ).cornerRadiusWithClipRRectOnly(
                  topLeft: AppCommonRadius.toInt(),
                  topRight: AppCommonRadius.toInt()),
              Positioned(
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: radius(18)),
                  child: Image.asset(avatar!,
                          height: 88, width: 88, fit: BoxFit.cover)
                      .cornerRadiusWithClipRRect(AppCommonRadius),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
