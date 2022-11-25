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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 350,
        child: GridView.count(
          padding: EdgeInsets.all(2),
          crossAxisCount: 2,
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
        ));
  }
  /*appBar: AppBar(
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
        body: Column(
          children: <Widget>[
            images.
                ? Container()
                : Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        Asset asset = images[index];
                        return AssetThumb(
                            asset: asset, width: 300, height: 300);
                      },
                    ))
          ],
        )
        /*Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: 1000,
              child: Text("갤러리"),
              color: Colors.red,
            ),
          ),
        );*/*/

  /*getImage() async {
    List<Asset> resultList =List.generate(9,((index) => );
    resultList =
        await MultiImagePicker.pickImages(maxImages: 10, enableCamera: true);
    setState(() {
      images = resultList;
    });
  }*/
}
