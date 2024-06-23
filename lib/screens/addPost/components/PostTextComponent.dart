import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class PostTextComponent extends StatelessWidget {
  const PostTextComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: svGetScaffoldColor(), borderRadius: radius(AppCommonRadius)),
      child: TextField(
        autofocus: false,
        maxLines: 15,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Whats On Your Mind',
          hintStyle: secondaryTextStyle(size: 12, color: svGetBodyColor()),
        ),
      ),
    );
  }
}
