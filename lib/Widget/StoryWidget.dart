import 'package:flutter/material.dart';

import '../Model/User.dart';

enum StoryType{
  NEW,
  OLD
}

class StoryWidget extends StatelessWidget{
  //시청 여부
  StoryType type;
  final String? image;
  final User user;
  StoryWidget({
    Key? key,
    required this.type,
    required this.image,
    required this.user,
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
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        //컬러 인스타마냥 섞는?
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.purple,
            Colors.orange,
          ]
        ),
        shape: BoxShape.circle
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(65),
          child: SizedBox(
            width: 65,
            height: 65,
            child: Image(image: NetworkImage(user.profile!),)
          ),
        ),
      ),
    );
  }

}
