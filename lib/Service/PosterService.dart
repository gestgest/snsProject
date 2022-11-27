import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/Poster.dart';


class PosterService extends ChangeNotifier {
  final PostCollection = FirebaseFirestore.instance.collection('poster');

  //QuerySnapshot
  //리스트 다 가져오는 함수
  Future<QuerySnapshot> read() async {
    //poster 목록 가져오기
    return await PostCollection.get();
    //무조건 then쓰지말고 await
    throw UnimplementedError(); // return 값 미구현 에러
  }

  Future<Poster> readPoster() async {
    final data = await PostCollection.get();
    print(Poster.fromJson(data.docs.first.data()).title);
    return Poster.fromJson(data.docs.first.data());
  }
    //title : 제목, uid : 유저id, thumbnail : 썸네일 이미지 주소
  void create(Poster poster) async {
    //, String keyword, double starScore, int busy
    // place 만들기
    await PostCollection.add(poster.toMap());
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
  void createDebug(Poster poster) async {
    //, String keyword, double starScore, int busy
    // place 만들기
    await PostCollection.add(poster.toMap());
    notifyListeners(); // 화면 갱신
  }
  void update(String docId, bool isDone) async {
    // place isDone 업데이트
  }
  //
  Future<void> debug(String uid) async
  {
    var data = await PostCollection.where('uid', isEqualTo: uid).get();
    //Future<QuerySnapshot<Map<String, dynamic>>>
    print(data.size);

  }

  //poster 삭제
  void delete(String id) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    print(id);
    PostCollection.doc(id).delete();
    notifyListeners(); // 화면 갱신

  }
  void deleteName(String name) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    final data= await PostCollection.where("title", isEqualTo: name).get();
    if(data.size != 0)
      data.docs[0].reference.delete();
    //final data =await PostCollection.doc("0k6BOakM2V5KKJIyqGtS");
    print(data.size);
    notifyListeners(); // 화면 갱신

  }
}
