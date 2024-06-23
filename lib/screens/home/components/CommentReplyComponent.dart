import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Common.dart';

class CommentReplyComponent extends StatelessWidget {
  const CommentReplyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      color: svGetScaffoldColor(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Divider(indent: 16, endIndent: 16, height: 20),
          Row(
            children: [
              16.width,
              Image.asset('images/tumy/faces/face_5.png',
                      height: 48, width: 48, fit: BoxFit.cover)
                  .cornerRadiusWithClipRRect(8),
              10.width,
              Container(
                width: context.width() * 0.6,
                child: AppTextField(
                  textFieldType: TextFieldType.OTHER,
                  decoration: InputDecoration(
                    hintText: 'Write A Comment',
                    hintStyle: secondaryTextStyle(color: svGetBodyColor()),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('Reply',
                      style: secondaryTextStyle(color: AppColorPrimary)))
            ],
          ),
        ],
      ),
    );
  }
}
