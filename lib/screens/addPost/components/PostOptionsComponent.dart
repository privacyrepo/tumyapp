import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tumy_app/utils/Common.dart';
import 'package:tumy_app/utils/Constants.dart';

class PostOptionsComponent extends StatefulWidget {
  final Function(List<File>) onImagesSelected;

  const PostOptionsComponent({Key? key, required this.onImagesSelected}) : super(key: key);

  @override
  State<PostOptionsComponent> createState() => _PostOptionsComponentState();
}

class _PostOptionsComponentState extends State<PostOptionsComponent> {
  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];

  Future<void> _pickImages() async {
    try {
      final List<XFile>? pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles != null) {
        List<File> newImages = pickedFiles.map((xfile) => File(xfile.path)).toList();
        setState(() {
          selectedImages.addAll(newImages);
        });
        widget.onImagesSelected(newImages);
      }
    } catch (e) {
      print("Error picking images: $e");
    }
  }

  Widget _buildImagePreview(File imageFile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.file(
          imageFile,
          // height: 52,
          // width: 82,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: svGetScaffoldColor(),
        borderRadius: radiusOnly(topRight: AppContainerRadius, topLeft: AppContainerRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: selectedImages.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return _buildImagePreview(selectedImages[index]);
                      },
                    )
                  : Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.grey[700],
                        size: 50.0,
                      ),
                    ),
            ),
          ),
          SizedBox(height: 8),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Image.asset('images/tumy/icons/ic_Video.png',
          //         height: 32, width: 32, fit: BoxFit.cover),
          //     Image.asset('images/tumy/icons/ic_Voice.png',
          //         height: 32, width: 32, fit: BoxFit.cover),
          //     Image.asset('images/tumy/icons/ic_Location.png',
          //         height: 32, width: 32, fit: BoxFit.cover),
          //     Image.asset('images/tumy/icons/ic_Paper.png',
          //         height: 32, width: 32, fit: BoxFit.cover),
          //   ],
          // ),
        ],
      ),
    );
  }
}
