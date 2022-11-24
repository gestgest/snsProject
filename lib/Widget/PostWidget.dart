import 'package:flutter/material.dart';

import 'StoryWidget.dart';

class PostWidget extends StatelessWidget{
  const PostWidget({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 25),
          _header(),
          SizedBox(height: 25),
          _image(),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("닉네임", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ],
    );
  }

  Widget _image(){
    return
      Image.asset('res/img/image.jpg', height: 200, width: 200,);
  }

}
