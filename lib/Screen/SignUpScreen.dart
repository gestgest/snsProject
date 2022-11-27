import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/main.dart';

import '../Model/User.dart';
class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {


  final ImagePicker _picker = ImagePicker();
  XFile? thumbnailXfild;

  void update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    
    return Consumer<UserService>(builder: (context, userService, child) {
      final String uid = FirebaseAuth.instance.currentUser!.uid;
      return FutureBuilder(
        future: userService.readUid(uid),
        builder: (BuildContext context, AsyncSnapshot<MyUser> user) {
          if (!user.hasData)
          {
            TextEditingController nameController = TextEditingController();
            return SingleChildScrollView(

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    avatar(),
                    Container(
                      width: 300,
                      child: TextField(

                          style: TextStyle(color: Colors.black, fontFamily: "DJ"),
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "닉네임",
                            hintStyle:
                            TextStyle(color: Colors.black),

                          )
                      ),
                    ),
                    ElevatedButton(onPressed: () {
                      if(nameController.text.isEmpty)
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("닉네임을 입력해 주세요"),
                        ));

                      else{
                        MyUser user = MyUser(name : nameController.text, uid : uid, profile: "https://firebasestorage.googleapis.com/v0/b/snsprojectfb.appspot.com/o/user%2FugpwLMrLZGF9hcCcpYcE%2FGithub.png?alt=media&token=0c302e9f-2a70-4ffb-bbb0-356c1d5038ad");
                        userService.create(user);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("안녕하세요 ${nameController.text}님!"),
                        ));

                        Navigator.pushNamedAndRemoveUntil(
                            context, '/', (_) => false);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }

                    }, child: Text("확인")),
                  ],
                ),
              ),
            );
          }
          //이미 아이디가 있다면
          else{
            return HomePage();
          }
          if (user.connectionState == ConnectionState.waiting ||
              !user.hasData) {
            return CircularProgressIndicator(); //버퍼링
          }
        },
      );
    });
  }

  Widget avatar() {
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          width: 350,
          height: 350,
          child: ElevatedButton(
          onPressed: () async {
            thumbnailXfild = await _picker.pickImage(
                source: ImageSource.gallery, imageQuality: 100);
            update();
          },
          child: ClipRRect(
            child: SizedBox(
              width: 350,
              height: 350,
              child: thumbnailXfild != null
                  ? Image.file(
                File(thumbnailXfild!.path),
                fit: BoxFit.cover,
              )
                  : Image.asset('res/img/image2.jpg', fit: BoxFit.cover),
            ),
          ),
        ),),
        const SizedBox(height: 30),
      ],
    );
  }
}
