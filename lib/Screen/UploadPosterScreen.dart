import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snsproject/Screen/HomeScreen.dart';
import 'package:snsproject/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
//final Future<XFile?> image = _picker.pickImage(source: ImageSource.gallery);
//final Future<List<XFile>?> images = _picker.pickMultiImage();

class UploadPosterScreen extends StatefulWidget {
  @override
  State<UploadPosterScreen> createState() => _UploadPosterScreenState();
}

class _UploadPosterScreenState extends State<UploadPosterScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = [];

  Future<void> _pickImg() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

  List<Widget> _boxContents = [
    IconButton(
        onPressed: () {
          _pickImg();
        },
        icon: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6), shape: BoxShape.circle),
            child: Icon(
              Icons.camera_alt,
              color: Colors.transparent,
            ))),
    Container(),
    Container(),
    _pickedImgs.length <= 4
        ? Container()
        : FittedBox(
            child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle),
                child: Text(
                  '+${(_pickedImgs.length - 4).toString()}',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w800),
                ))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("새 게시물"),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  print('Next Page');
                },
              ),
            ]),
        body: SizedBox(
            height: 513,
            child: GridView.count(
              padding: EdgeInsets.all(2),
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              children: List.generate(
                  4,
                  (index) => DottedBorder(
                      child: Container(),
                      color: Colors.grey,
                      dashPattern: [5, 3],
                      borderType: BorderType.RRect,
                      radius: Radius.circular(10))).toList(),
            )));
  }
}
