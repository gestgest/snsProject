import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/MyUser.dart';
import '../Service/UserService.dart';
import 'StoryWidget.dart';

class PostWidget extends StatelessWidget {
  PostWidget({Key? key, required this.data, required this.showFriend}) : super(key: key);

  bool showFriend;
  final QueryDocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    String myuid = FirebaseAuth.instance.currentUser!.uid;
    return Consumer<UserService>(builder: (context, userService, child)
    {
      return FutureBuilder(
          future: userService.readUid(myuid),
        builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if(showFriend)
            {
              bool isFriend = false;
              for(String s in snapshot.data!.friends!)
              {
                if(s == data['uid'])
                {
                  isFriend = true;
                }
              }
              //친구가 아니면 차단
              if(!isFriend)
                {
                  return Container();
                }
            }


            return Container(
                child: Column(
                  children: [
                    SizedBox(height: 25),
                    _image(),
                    SizedBox(height: 15),
                    _header(),
                    Row(
                      children: [],
                    ),
                    SizedBox(height: 15),
                  ],
                ));
          }
          else
            return Container();
        },

      );
    });
  }

  //
  //alignment: Alignment.bottomCenter,
  Widget _header() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //제목
          Text(
            data['title'],
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          //설명?
          //설정
        ],
      ),)
    ;
  }

  Widget _image() {
    return Image(
      image: NetworkImage(data['thumbnail']),
      height: 200,
      width: 200,
    );
  }

  //좋아요 이런거
  Widget _icons() {
    return Container();
    //좋아요 개수
    //내용
    //닉네임
  }
//구분선?
// 만약 댓글 버튼을 눌러서 true면 댓글 내용을 보여줌

}
