import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Model/User.dart';


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
  Future<User> readUser() async {
    //poster 목록 가져오기
    final data = await UserCollection.get();
    User user = User.fromJson(data.docs.first.data());
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
  void create(User user) async
  {
    await UserCollection.add(user.toMap());
  }

  void update(String docId, bool isDone) async {
    // place isDone 업데이트
  }

  void searchName(String uid)
  {
    final data = UserCollection.where('uid', isEqualTo: uid).get();

  }

  void delete(String id) async {
    //final project= placeCollection.where("uid", isEqualTo: uid);
    print(id);
    UserCollection.doc(id).delete();
    notifyListeners(); // 화면 갱신

  }
}
