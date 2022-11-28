import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/MyUser.dart';


class UserService extends ChangeNotifier {
  final UserCollection = FirebaseFirestore.instance.collection('user');

  //QuerySnapshot
  //리스트 다 가져오는 함수
  Future<QuerySnapshot> read() async {
    //poster 목록 가져오기
    return await UserCollection.get();
    //무조건 then쓰지말고 await
    throw UnimplementedError(); // return 값 미구현 에러
  }
  Future<MyUser> readUser(String name) async {
    //poster 목록 가져오기
    final data = await UserCollection.where('name', isEqualTo: name).get();
    //하는 과정에 오류
    MyUser user = MyUser.fromJson(data.docs.first.data());
    return user;
    //무조건 then쓰지말고 await
    throw UnimplementedError(); // return 값 미구현 에러
  }

  Future<MyUser> readUid(String uid) async {
    //poster 목록 가져오기
    final data = await UserCollection.where('uid', isEqualTo: uid).get();
    print(uid);

    //배열 일일이 넣어야 할듯
    MyUser user = MyUser.fromJson(data.docs.first.data());
    return user;
    //무조건 then쓰지말고 await
    throw UnimplementedError(); // return 값 미구현 에러
  }


  /*  //title : 닉네임, uid : 유저id, thumbnail : 프로필 사진 주소
  void create(String name, String uid, String profile) async {
    //, String keyword, double starScore, int busy
    // place 만들기
    await UserCollection.add(
      {
        'name': name,
        'uid': uid,
        'profile': profile
      },
    );
    notifyListeners(); // 화면 갱신
  }
  */
  //맵 버전
  void create(MyUser user) async
  {
    await UserCollection.add(user.toMap());
  }

  void update(MyUser user) async {
    // place isDone 업데이트
    await deleteUid(user.uid!);
    create(user);
  }

  void searchName(String uid)
  {
    final data = UserCollection.where('uid', isEqualTo: uid).get();

  }

  void delete(String id) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    UserCollection.doc(id).delete();
    notifyListeners(); // 화면 갱신
  }
  Future<void> deleteUid(String uid) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    final data = await UserCollection.where('uid', isEqualTo: uid).get();

    if(data.size != 0)
      data.docs[0].reference.delete();
    //UserCollection.doc(id).delete();
    notifyListeners(); // 화면 갱신
  }
}
