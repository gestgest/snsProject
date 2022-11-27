import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/Story.dart';



class StoryService extends ChangeNotifier {
  final storyCollection = FirebaseFirestore.instance.collection('story');

  //QuerySnapshot
  //리스트 다 가져오는 함수
  Future<QuerySnapshot> read() async {
    //poster 목록 가져오기
    return await storyCollection.get();
    //무조건 then쓰지말고 await
    throw UnimplementedError(); // return 값 미구현 에러
  }

  //title : 제목, uid : 유저id, thumbnail : 썸네일 이미지 주소
  void create(Story story) async {
    //, String keyword, double starScore, int busy
    // place 만들기
    await storyCollection.add(story.toMap());
    notifyListeners(); // 화면 갱신
  }
  /*
    await PostCollection.add(
      {
        'uid': uid,
        'title': title,
        'thumbnail': thumbnail
      },
    );
    notifyListeners(); // 화면 갱신

    */
  //

  //poster 삭제
  void delete(String name) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    notifyListeners(); // 화면 갱신

  }
}
