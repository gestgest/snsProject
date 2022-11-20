import 'package:flutter/material.dart';

class MyPageScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child : Column(
        children: [
          SizedBox(height:50),
          CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('res/img/image.jpg'),
          ),
          SizedBox(height:20),
          Text("닉네임"),
        ],
      )
    );
  }

}