import 'package:flutter/material.dart';

import 'StoryWidget.dart';

class PostWidget extends StatelessWidget{
  const PostWidget({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _header(),
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
        Text("닉네임"),
      ],
    );
  }

  Widget _image(){
    return
      Image.asset('res/img/image.jpg', height: 200, width: 200,);
  }

}
