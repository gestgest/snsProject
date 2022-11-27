import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';


//프로필
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXfild;

  void update() => setState(() {});

  Widget _avatar(){
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(300),
          child: SizedBox(
            width: 350,
            height: 350,
            child: thumbnailXfild!=null
                ? Image.file(
                File(thumbnailXfild!.path),
                fit: BoxFit.cover,
            )
            : Image.asset('res/img/image2.jpg',
                fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: () async{
          thumbnailXfild = await _picker.pickImage(
              source: ImageSource.gallery,imageQuality: 100);
          update();
          }, child: Text('이미지 업로드'),
        ),
        const SizedBox(height: 30),
        ElevatedButton(onPressed: (){},  // 확인 누를 시 회원가입 입력 정보, 프로필 정보 받아가기
            child: Text('확인'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('프로필 등록'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app_sharp,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _avatar(),
          ],
        ),
      ),
    );
  }
}
