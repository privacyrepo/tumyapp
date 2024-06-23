import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/main.dart';
import 'package:tumy_app/screens/addPost/components/SharePostBottomSheetComponent.dart';
import 'package:tumy_app/utils/Colors.dart';
import 'package:tumy_app/utils/Constants.dart';

InputDecoration svInputDecoration(BuildContext context,
    {String? hint,
    String? label,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    Widget? prefix,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon}) {
  return InputDecoration(
    contentPadding: contentPadding,
    labelText: label,
    hintText: hint,
    hintStyle: hintStyle ?? secondaryTextStyle(),
    labelStyle: labelStyle ?? secondaryTextStyle(),
    prefix: prefix,
    prefixIcon: prefixIcon,
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: AppBorderColor)),
    focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: AppColorPrimary)),
    border:
        UnderlineInputBorder(borderSide: BorderSide(color: AppColorPrimary)),
    focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0)),
    errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.0)),
    alignLabelWithHint: true,
  );
}

Widget svRobotoText(
    {required String text,
    Color? color,
    FontStyle? fontStyle,
    Function? onTap,
    TextAlign? textAlign}) {
  return Text(
    text,
    style: secondaryTextStyle(
      fontFamily: svFontRoboto,
      color: color ?? svGetBodyColor(),
      fontStyle: fontStyle ?? FontStyle.normal,
    ),
    textAlign: textAlign ?? TextAlign.center,
  ).onTap(onTap,
      splashColor: Colors.transparent, highlightColor: Colors.transparent);
}

Color svGetBodyColor() {
  if (appStore.isDarkMode)
    return BodyDark;
  else
    return BodyWhite;
}

Color svGetScaffoldColor() {
  if (appStore.isDarkMode)
    return appBackgroundColorDark;
  else
    return AppLayoutBackground;
}

Widget svHeaderContainer(
    {required Widget child, required BuildContext context}) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Container(
        width: context.width(),
        decoration: BoxDecoration(
            color: AppColorPrimary,
            borderRadius: radiusOnly(
                topLeft: AppContainerRadius, topRight: AppContainerRadius)),
        padding: EdgeInsets.all(24),
        child: child,
      ),
      Container(
        height: 20,
        decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: radiusOnly(
                topLeft: AppContainerRadius, topRight: AppContainerRadius)),
      )
    ],
  );
}

Widget svAppButton(
    {required String text,
    required Function onTap,
    double? width,
    required BuildContext context}) {
  return AppButton(
    shapeBorder: RoundedRectangleBorder(borderRadius: radius(AppCommonRadius)),
    text: text,
    textStyle: boldTextStyle(color: Colors.white),
    onTap: onTap,
    elevation: 0,
    color: AppColorPrimary,
    width: width ?? context.width() - 32,
    height: 56,
  );
}

Future<File> svGetImageSource() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.camera);
  return File(pickedImage!.path);
}

void svShowShareBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    enableDrag: true,
    isDismissible: true,
    backgroundColor: context.cardColor,
    shape: RoundedRectangleBorder(
        borderRadius: radiusOnly(topLeft: 30, topRight: 30)),
    builder: (context) {
      return SharePostBottomSheetComponent();
    },
  );
}
