import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snsproject/Screen/HomeScreen.dart';
import 'package:snsproject/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart';
import 'package:path_icon/path_icon.dart';
import 'package:photo_manager/photo_manager.dart';
//final Future<XFile?> image = _picker.pickImage(source: ImageSource.gallery);
//final Future<List<XFile>?> images = _picker.pickMultiImage();

class UploadPosterScreen extends StatefulWidget {
  @override
  State<UploadPosterScreen> createState() => _UploadPosterScreenState();
}

class _UploadPosterScreenState extends State<UploadPosterScreen> {
  var albums = <AssetPathEntity>[];
  var headerTitle = '';
  var imageList = <AssetEntity>[];
  AssetEntity? selectedImage;
  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  void _loadPhotos() async {
    var result = await PhotoManager.requestPermissionExtend();
    if (result.isAuth) {
      albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          imageOption: const FilterOption(
            sizeConstraint: SizeConstraint(minHeight: 100, minWidth: 100),
          ),
          orders: [
            const OrderOption(type: OrderOptionType.createDate, asc: false),
          ],
        ),
      );
      _loadData();
    } else {}
  }

  void update() => setState(() {});

  void _loadData() async {
    headerTitle = albums.first.name;
    await _pagingPhotos();
    update();
  }

  Future<void> _pagingPhotos() async {
    var photos = await albums.first.getAssetListPaged(page: 0, size: 30);
    imageList.addAll(photos);
    selectedImage = imageList.first;
  }

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

  Widget _imagePreview() {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width,
      color: Colors.grey,
      child: selectedImage == null
          ? Container()
          : _photoWidget(selectedImage!, width.toInt(), builder: (data) {
              return Image.memory(
                data,
                fit: BoxFit.cover,
              );
            }),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height),
                builder: (_) => Container(
                  height: albums.length * 55,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black45,
                            ),
                            width: 40,
                            height: 4,
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                albums.length,
                                (index) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  child: Text(albums[index].name),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Text(
                    headerTitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    color: const Color(0xff808080),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Icon(Icons.square_foot),
                    const SizedBox(
                      width: 7,
                    ),
                    const Text(
                      '여러 항목 선택',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff808080),
                ),
                child: Icon(Icons.camera_alt),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageSelectList() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
      ),
      itemCount: imageList.length,
      itemBuilder: (BuildContext context, int index) {
        return _photoWidget(imageList[index], 200, builder: (data) {
          return GestureDetector(
            onTap: () {
              selectedImage = imageList[index];
              update();
            },
            child: Opacity(
              opacity: imageList[index] == selectedImage ? 0.5 : 1,
              child: Image.memory(
                data,
                fit: BoxFit.cover,
              ),
            ),
          );
        });
      },
    );
  }

  /*uploadImage() async {
    print(_pickedImgs.toString());
    var dio = Dio();
    try {
      List<MultipartFile> multipartImgList = [];

      for (int i = 0; i < _pickedImgs.length; i++) {
        var pic = await MultipartFile.fromFile(_pickedImgs[i].path,
            contentType: new MediaType("image", "jpg"));
        multipartImgList.add(pic);
      }

      FormData formData = new FormData.fromMap({
        "images": multipartImgList,
      });

      dio.options.headers["authorization"] = context.read<AuthProvider>().token.toString();
      
      dio
          .post(
            uploadHospVideoUrl.toString(),
            data: formData,
          )
          .then((value) => print(value));
      print(context.read<AuthProvider>().token.toString());
    } catch (e) {
      print(e);
    }
  };*/
/*
  @override
  Widget build(BuildContext context) {
    bool isPadMode = MediaQuery.of(context).size.width > 700;

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
                color: Theme.of(context).colorScheme.primary,
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
*/
  Widget _photoWidget(AssetEntity asset, int size,
      {required Widget Function(Uint8List) builder}) {
    return FutureBuilder(
        future: asset.thumbnailDataWithSize(ThumbnailSize.square(size)),
        builder: (_, AsyncSnapshot<Uint8List?> snapshot) {
          if (snapshot.hasData) {
            return builder(snapshot.data!);
          } else {
            return Container();
          }
        });
  }

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
      body: SingleChildScrollView(
        child: Column(children: [
          _imagePreview(),
          _header(),
          _imageSelectList(),
        ]),
      ),
    );
  }
}
