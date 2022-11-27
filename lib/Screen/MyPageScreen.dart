import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/UserService.dart';

import '../Model/User.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({Key? key}) : super(key: key);

  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPageScreen> {
  //오른쪽 위에 Appbar에 햄버거 버튼 = 블로그 메뉴 마냥 햄버거 버튼
  //그 왼쪽에는 설정
  //왼쪽 위 앱바에 친구 아이콘
  //메인은 프로필 사진[버튼 누르면 프사 변경] + 구분선 + 그냥 자기 게시물
  //
  //auth 서비스랑 연동해야됨
  @override
  Widget build(BuildContext context) {
    //오른쪽 위에 Appbar에 햄버거 버튼 = 블로그 메뉴 마냥 햄버거 버튼
    //그 왼쪽에는 설정
    //왼쪽 위 앱바에 친구 아이콘
    //메인은 프로필 사진[버튼 누르면 프사 변경] + 구분선 + 그냥 자기 게시물
    //
    return Container(
        child : Scaffold(
            appBar: AppBar(

            ),
            body : ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height:50),
                    CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('res/img/image.jpg'),
                    ),
                    SizedBox(height:20),
                    Text("닉네임"),
                  ],
                )
              ],
            )
        )

    );
  }
}
