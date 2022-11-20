import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
          title: Text("스토리"),
      ),
      body : Center(
        child: ListView(
          children: _listPoster(10),

        )
      ),


    );

    //스토리
    //body
    // - 사진 / 좋아요, 댓글
  }

  List<Widget> _listPoster(int index){
    List<Widget> posters = [];
    //더미 게시물
    for(int i = 0; i < index; i++)
    {
      posters.add(
          Container(
            child: Column(
                children : [
                  Text("닉네임"),
                  Image.asset('res/img/image.jpg'),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Colors.black,
                        ),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: Colors.black,
                        ),
                        onPressed: (){},
                      ),
                    ],
                  ),
                  SizedBox(height : 50),
                ],
                //mainAxisAlignment : MainAxisAlignment.start
                crossAxisAlignment : CrossAxisAlignment.start
            ),
          )
      );
    }


    return posters;
  }
}
