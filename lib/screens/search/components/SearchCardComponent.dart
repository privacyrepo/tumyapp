import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/firebase/models/FirestoreModels.dart' hide Image;
import 'package:tumy_app/utils/Common.dart';

class SearchCardComponent extends StatelessWidget {
  final SearchModel element;

  SearchCardComponent({required this.element});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            element.type == 'user' && element.avatar.isNotEmpty
                ? Image.network(element.avatar.validate(),
                        height: 56, width: 56, fit: BoxFit.cover)
                    .cornerRadiusWithClipRRect(8)
                : element.type == 'post' && element.postImage.isNotEmpty
                    ? Image.network(element.postImage.validate(),
                            height: 56, width: 56, fit: BoxFit.cover)
                        .cornerRadiusWithClipRRect(8)
                    : Container(
                        height: 56,
                        width: 56,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.person, size: 32, color: Colors.white),
                      ),
            20.width,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(element.name.validate(), style: boldTextStyle()),
                    6.width,
                    element.isOfficial
                        ? Image.asset('images/tumy/icons/ic_TickSquare.png',
                            height: 14, width: 14, fit: BoxFit.cover)
                        : Offstage(),
                  ],
                  mainAxisSize: MainAxisSize.min,
                ),
                6.height,
                Text(element.content.validate(),
                    style: secondaryTextStyle(color: svGetBodyColor())),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            // Implement the functionality for closing/removing the search card here
          },
          child: Image.asset(
            'images/tumy/icons/ic_CloseSquare.png',
            height: 20,
            width: 20,
            fit: BoxFit.cover,
            color: context.iconColor,
          ),
        ),
      ],
    ).paddingAll(16);
  }
}
