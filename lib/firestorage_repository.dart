import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';


class FirestorageRepository {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String?> uploadFile(
      String filePath,
      String fileName,
      )async{
    File file = File(filePath);
    try{
      print(filePath);
      //데이터베이스 타입/고유id/파일이름
      Reference ref = await storage.ref('${fileName}');

      await ref.putFile(file);

      final s = await getImageUrl(ref);
      //ref 매개변수만 같다면 가능하다.
      print("주소 오류" + s);

      return s;
      //ref가 저장되는 storage, file은 그 sdk 파일경로
    } on FirebaseException catch (e){

      print("이미지 주소 -> ㄹ서버 오류" + e.message!);
    }

  }
  //이미지 가져오기 [단수형]
  Future<String> getImageUrlString(String fileName) async {
    Reference ref =  await storage.ref('image/$fileName');
    return await ref.getDownloadURL();
  }

  //이미지 주소로 이미지를 가져온다.
  Future<String> getImageUrl(Reference ref) async {
    return await ref.getDownloadURL();
  }


}
