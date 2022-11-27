import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Model/Story.dart';
import 'package:snsproject/Service/PosterService.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/Widget/StoryWidget.dart';
import 'package:snsproject/Widget/postWidget.dart';

import '../Model/Poster.dart';
import '../Model/User.dart';
import '../Service/StoryService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PosterService>(builder: (context, posterService, child) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
              child: Column(
            children: [
              Text("title"),
            ],
          )),
        ),
        body: Center(
          //두개의 스크롤을 쓰기 위해서 위젯의 크기를 고정시켜야 한다.
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Container(child: _storyList(), width: 400, height: 100,),
                  FutureBuilder(
                      future: posterService.read(), //Future <T>
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data!.size,

                                //snapshot 데베 for문
                                itemBuilder: (BuildContext context, int index) {
                                  return PostWidget(
                                      data: snapshot.data!.docs[index]);
                                  //return placeList(snapshot.data!);
                                }),
                          );
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            !snapshot.hasData) {
                          return CircularProgressIndicator(); //버퍼링
                        }
                        return Container();
                      }),
                ],
              )),
        ),
      );
      //body
      // - 사진 / 좋아요, 댓글
    });
  }

  //스토리
  Widget _storyList() {
    return Consumer<StoryService>(builder: (context, storyService, child) {
      return FutureBuilder(
          future: storyService.read(), //Future <T>
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  //snapshot 데베 for문
                  itemBuilder: (BuildContext context, int index) {
                    //data: snapshot.data!.docs[index]
                    //var story = snapshot.data!.docs.map<Story>((e) => Story.fromJson(e.id, e.data()) );

                    var data = snapshot.data!.docs[index];
                    String name = data['user']['name'];
                    String profile = data['user']['profile'];
                    String uid = data['user']['uid'];
                    final user = MyUser(name : name, profile: profile, uid: uid);
                    return StoryWidget(
                      type: StoryType.NEW,
                      image: data['image'],
                      user : user,
                    );
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
}
