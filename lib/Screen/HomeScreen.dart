import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/PosterService.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/Widget/StoryWidget.dart';
import 'package:snsproject/Widget/postWidget.dart';

import '../Model/Poster.dart';

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
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            child: Column(
            children: [
              _storyList(),
              FutureBuilder(
                  future: posterService.read(), //Future <T>
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    List<NetworkImage> list = [];
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
                              return PostWidget(data: snapshot.data!.docs[index]);
                              //return placeList(snapshot.data!);
                            }),
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

  //스토리
  Widget _storyList()
  {
    //고정됐는데 움직이는 스크롤 뷰
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(

        children: List.generate(
            20,
            (index) =>  StoryWidget(type: StoryType.NEW)
        ),
      ),
    );
  }

}
