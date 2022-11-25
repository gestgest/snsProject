import 'package:snsproject/Screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'ProfileScreen.dart';
import 'custom_text_form_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:
            AppBar(elevation: 0, centerTitle: true, title: const Text('회원 등록')),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: ListView(
              children: [
                SizedBox(height: 70),
                CustomTextFormField(hint: "사용하실 닉네임을 입력"), // 텍스트 폼
                CustomTextFormField(hint: "사용하실 이메일을 입력"),
                CustomTextFormField(hint: "사용하실 비밀번호를 입력"),
                CustomTextFormField(hint: "사용하실 비밀번호를 재 입력"),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProfileScreen())); // 우선 pop으로 다시 두번째페이지(회원가입)에서 다시 첫페이지(로그인페이지)로 이동 시키는걸로 해두었음
                      },
                      child: Text("가입 완료")),
                )
              ],
            )));
  }
}

// 회원가입 페이지 닉네임 입력 위 쪽에 프로필 등록 구현 필요