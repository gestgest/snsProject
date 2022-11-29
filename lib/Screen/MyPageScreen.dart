import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/Widget/AddFriendWidget.dart';

import '../Model/MyUser.dart';

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
    User user = FirebaseAuth.instance.currentUser!;
    //오른쪽 위에 Appbar에 햄버거 버튼 = 블로그 메뉴 마냥 햄버거 버튼
    //그 왼쪽에는 설정
    //왼쪽 위 앱바에 친구 아이콘
    //메인은 프로필 사진[버튼 누르면 프사 변경] + 구분선 + 그냥 자기 게시물
    //
    //FirebaseAuth.instance.currentUser
    return Consumer<UserService>(builder: (context, userService, child) {

      return Scaffold(
        appBar: AppBar(
            title: Container(
        )),
        body: FutureBuilder(
          future: userService.readUid(user.uid),
          builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {

              return ListView(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 50),
                      CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(snapshot.data!.profile!),
                      ),
                      SizedBox(height: 20),
                      Text(snapshot.data!.name!),
                      SizedBox(height: 20),

                      SignOutButton(),
                    ],
                  )
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return CircularProgressIndicator(); //버퍼링
            } else
              return Container();
          },
        ),

        endDrawer: Drawer(
            child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.home),
              title: Text("친구 목록"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            //친구 목록들
            _friendsWidgets(),

          ],
        )),
      );
    });
  }
}

Widget _friendsWidgets(){
  return Consumer<UserService>(builder: (context, userService, child) {
    return FutureBuilder(
        future: userService.read(), //Future <T>
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.size,
                //snapshot 데베 for문
                itemBuilder: (BuildContext context, int index) {
                  //data: snapshot.data!.docs[index]
                  var data = snapshot.data!.docs[index];
                  //var story = snapshot.data!.docs.map<Story>((e) => Story.fromJson(e.id, e.data()) );
                  String name = data['name'];
                  String profile = data['profile'];
                  String myuid = data['uid'];
                  List<String> myfriends = [];

                  if(myuid == FirebaseAuth.instance.currentUser!.uid)
                    return Container();
                  for(String s in data['friends'])
                  {
                    myfriends.add(s);
                  }

                  //print(data['friends']);


                  final user = MyUser(name : name, profile: profile,uid :myuid, friends: myfriends);
                  //return Container();
                  return Column(children: [
                    SizedBox(height: 10,),
                    AddFriendWidget(user: user),
                  ],);
                  //return placeList(snapshot.data!);
                });
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return CircularProgressIndicator(); //버퍼링
          }
          return Container();
        });
  });
}

