import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/PosterService.dart';
import 'package:snsproject/Service/StoryService.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/Widget/StoryWidget.dart';
import 'package:snsproject/Widget/postWidget.dart';

import '../Model/Poster.dart';
import '../Model/Story.dart';
import '../Model/MyUser.dart';

class DebugWidget extends StatefulWidget {
  const DebugWidget({Key? key}) : super(key: key);
  _DebugWidgetState createState() => _DebugWidgetState();
}

class _DebugWidgetState extends State<DebugWidget> {
  @override
  Widget build(BuildContext context) {

    return Consumer3<PosterService,UserService, StoryService>(builder: (context, posterService,userService,storyService, child) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
              child: Column(
                children: [
                  Text("debug"),
                ],
              )),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder(
                    future: userService.readUser("curry"), //Future <T>
                    builder: (BuildContext context,
                        AsyncSnapshot<MyUser> snapshot) {

                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        String ss = "https://firebasestorage.googleapis.com/v0/b/snsprojectfb.appspot.com/o/user%2FugpwLMrLZGF9hcCcpYcE%2FGithub.png?alt=media&token=0c302e9f-2a70-4ffb-bbb0-356c1d5038ad";


                        return Column(
                            children : [
                              ElevatedButton(
                                child: Text("dd"),
                                onPressed: () {
                                  String ss = "https://firebasestorage.googleapis.com/v0/b/snsprojectfb.appspot.com/o/poster%2F8ovh47lzzTViQspJde0Q%2Fthumbnail%2Fimage.jpg?alt=media&token=6441819d-2a13-4832-98e9-fb83fbff7ab0";
                                  Poster poster = Poster(title : "펭귄",uid : snapshot.data!.uid,thumbnail : ss,user:snapshot.data!);
                                  posterService.create(poster);
                                },
                              ),
                              ElevatedButton(
                                child: Text("add user"),
                                onPressed: () {
                                  List<String> ssf = ["aVLoDXQiKidZJXszmy1VcFdVRHa2", "tetet"];
                                  userService.create( MyUser(name : "ppap", uid: "tetet", profile: ss, friends: ssf));
                                },
                              ),
                              ElevatedButton(
                                child: Text("친구가 있니"),
                                onPressed: () {
                                  print(snapshot.data!.friends![0]);
                                  //posterService.deleteName("레고고고");
                                },
                              ),
                              ElevatedButton(
                                child: Text("storyadd"),
                                onPressed: () {
                                  DateTime time = DateTime.now();
                                  Story story = Story(image : ss, user : snapshot.data, time : time);
                                  storyService.create(story);

                                  //posterService.deleteName("레고고고");
                                },
                              )
                              
                          ]
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          !snapshot.hasData) {
                        return CircularProgressIndicator(); //버퍼링
                      }
                      return Container();
                    }),
              ],
            )),
      );
      //body
      // - 사진 / 좋아요, 댓글
    });
  }

}
