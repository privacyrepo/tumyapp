import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class PostTextComponent extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const PostTextComponent({
    Key? key,
    required this.titleController,
    required this.descriptionController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: svGetScaffoldColor(), borderRadius: radius(AppCommonRadius)),
          child: TextField(
            controller: titleController,
            autofocus: false,
            maxLines: 1,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: secondaryTextStyle(size: 12, color: svGetBodyColor()),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: svGetScaffoldColor(), borderRadius: radius(AppCommonRadius)),
          child: TextField(
            controller: descriptionController,
            autofocus: false,
            maxLines: 15,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'What\'s On Your Mind',
              hintStyle: secondaryTextStyle(size: 12, color: svGetBodyColor()),
            ),
          ),
        ),
      ],
    );
  }
}
