import 'package:flutter/material.dart';
import 'package:snsproject/Widget/StoryWidget.dart';
import 'package:snsproject/Widget/postWidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Column(
            children: [
              Text("title"),
            ],
          )
        ),
      ),
      body: ListView(
          children: [
            _storyList(),
            _listPoster(),
          ],
      ),
    );

    //스토리
    //body
    // - 사진 / 좋아요, 댓글
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

  Widget _listPoster( ){
    return Column(
      children: List.generate(20, (index) => PostWidget()),
    );
  }
}
