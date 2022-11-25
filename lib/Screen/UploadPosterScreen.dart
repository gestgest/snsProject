import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

//업로드 포스터
class UploadPosterScreen extends StatelessWidget {
  //final ImagePicker picker = ImagePicker();
  //PickedFile? pick_image;
  //pick_image == null ? Text('No image') : Image.file(File(pick_image.path))
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("새 게시물"),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  print('Next Page');
                },
              ),
            ]),
        body: Column(children: [
          Container(
            child: Center(
              child: Text("올릴 사진"),
            ),
            color: Colors.blue,
            height: 300,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(
              width: 1000,
              child: Text("갤러리"),
              color: Colors.red,
            ),
          ),
        ]));
  }
}
