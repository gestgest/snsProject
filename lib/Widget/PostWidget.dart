import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'StoryWidget.dart';

class PostWidget extends StatelessWidget{
  PostWidget({Key? key, required this.data}) : super(key:key);

  final QueryDocumentSnapshot<Object?> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 25),
          _image(),
          SizedBox(height: 15),
          _header(),
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
        ],
      )
    );
  }

  Widget _header(){
    return Row(
      children: [
        SizedBox(width: 10,),
        //제목
        Text(data['title'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        //설명?
        //설정
      ],
    );
  }

  Widget _image(){
    return
      Image(image:NetworkImage(data['thumbnail']), height: 200, width: 200,);
  }

  //좋아요 이런거
  Widget _icons(){
    return Container();
    //좋아요 개수
    //내용
    //닉네임
  }
  //구분선?
  // 만약 댓글 버튼을 눌러서 true면 댓글 내용을 보여줌

}
