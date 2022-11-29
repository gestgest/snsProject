import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../Model/MyUser.dart';
import '../Model/Poster.dart';
import '../Service/PosterService.dart';
import '../Service/UserService.dart';
import '../Widget/custom_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snsproject/Screen/HomeScreen.dart';
import 'package:snsproject/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

import '../firestorage_repository.dart';

//final Future<XFile?> image = _picker.pickImage(source: ImageSource.gallery);
//final Future<List<XFile>?> images = _picker.pickMultiImage();

class UploadPosterScreen extends StatefulWidget {
  @override
  State<UploadPosterScreen> createState() => _UploadPosterScreenState();
}

class _UploadPosterScreenState extends State<UploadPosterScreen> {
  final ImagePicker _picker = ImagePicker();
  final FirestorageRepository storage = FirestorageRepository();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController posterTitleController = TextEditingController();
  XFile? _pickedFile;
  String? loadImgUrl;
  String? posterAddress;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PosterService>(
      builder: (context, posterService, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "게시물 등록 페이지",
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontFamily: 'DJ',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          body: CustomScrollView(
            //expanded 사용하기 위해 SingleScrollView 대신 CustomScrollView사용
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _imagebody()),
                    Center(
                      //장소를 입력하는 textField
                      child: Container(
                        height: 50,
                        width: 320,
                        child: TextField(
                          controller: posterTitleController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            hintText: "장소 이름을 입력해주세요",
                          ),
                        ),
                      ),
                    ),
                    Center(
                      //스토어에 추가할 데이터를 저장하는 create버튼
                      child: ElevatedButton(
                        onPressed: () {
                          //★ 만약 이미지도 비어있다면도 추가
                          if (posterTitleController.text.isNotEmpty) {
                            //동의를 구해서 파베에 올리고
                            _showAlert(posterService, uid);


                            //업데이트
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            textStyle:
                                TextStyle(fontFamily: "DJ", fontSize: 15)),
                        child: const Text('create'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //이미지 업로드
  Future<void> sendImageToFireStorage(String id) async {
    XFile? pickedFile = _pickedFile;
    if (pickedFile != null || id != null) {
      //url 주소값 반환
      loadImgUrl = await storage.uploadFile(pickedFile!.path, "poster/"+id+"thumnail.png");
      // FireStorage에 이미지파일 업로드
    }

  }

  void _showAlert(PosterService ps, String uid) {


    // 화면 추가 선택 다이어로그
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Consumer<UserService>(builder: (context, userService, child) {
            return FutureBuilder(
              future: userService.readUid(uid),
              builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
                return CupertinoAlertDialog(
                  title: Text("추가하시겠습니까?"),
                  actions: [
                    CupertinoDialogAction(
                      //추가 동의
                        isDefaultAction: true,
                        child: Text("확인"),
                        onPressed: () async {
                          //아직 이미지 업로드는 안됨
                          //ps, user
                          //임시 썸네일
                          String ss = "https://firebasestorage.googleapis.com/v0/b/snsprojectfb.appspot.com/o/poster%2F8ovh47lzzTViQspJde0Q%2Fthumbnail%2Fimage.jpg?alt=media&token=6441819d-2a13-4832-98e9-fb83fbff7ab0";
                          Poster poster = Poster(title: posterTitleController.text, thumbnail: ss,user : snapshot.data!, uid : uid);
                          String id = await ps.createGetID(poster);
                          //나중에 address 반환값 받는거 추가

                          sendImageToFireStorage(id);
                          loadCreate(ps, poster, id);



                        }),
                    CupertinoDialogAction(
                      //추가 비동의
                        isDefaultAction: true,
                        child: Text("취소"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          });
        });
  }

  Future<void> loadCreate(PosterService ps,Poster poster,String id ) async
  {

    Future.delayed(
        const Duration(milliseconds: 100),
            () {
          if (loadImgUrl != null) {

            poster.thumbnail = loadImgUrl;
            ps.updateId(poster, id);
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (_) => false);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (_) => false);
            loadImgUrl = null;
            print("확인");
          }
          else
            loadCreate(ps,poster,id);
        }
    );

  }

  Widget _imagebody() {
    if (_pickedFile != null) {
      return _imageCard(); // pickedFiles != null
    } else {
      return _uploaderCard(); // pickedFiles == null
    }
  }

  Widget _imageCard() {
    // 업로드된 이미지 파일이 있을 시 이 화면이 출력됨
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    //선택된 이미지 삭제 메뉴
    return FloatingActionButton(
      onPressed: () {
        _clear();
      },
      backgroundColor: Colors.redAccent,
      tooltip: 'Delete',
      child: const Icon(Icons.delete),
    );
  }

  Widget _uploaderCard() {
    //이미지 파일이 없을 시 이 화면이 출력됨
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.9),
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                    color: Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.9)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                //업로드 버튼
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontFamily: "DJ", fontSize: 15)),
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        //임시 pickedFiles
        _pickedFile = pickedfile;
      });
    }
  }

//이미지 선택 초기화
  void _clear() {
    setState(() {
      _pickedFile = null;
    });
  }
}
