import 'package:flutter/material.dart';

enum StoryType{
  NEW,
  OLD
}

class StoryWidget extends StatelessWidget{
  //시청 여부
  StoryType type;
  String? nickname;

  StoryWidget({
    Key? key,
    required this.type,
    this.nickname,
  }) : super (key : key);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case StoryType.NEW:
        return newWidget();
        break;
      case StoryType.OLD:
        return Container();
        break;
    }
  }

  Widget newWidget(){
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        //컬러 인스타마냥 섞는?
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple,
            Colors.orange,
          ]
        ),
        shape: BoxShape.circle
      ),
      child: Container(),
    );
  }

}
