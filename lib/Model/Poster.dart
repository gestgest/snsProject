import 'User.dart';

class Poster{
  final String? title;
  final String? uid;
  final String? thumbnail;
  User? user;
  Poster({
    this.title,
    this.uid,
    this.thumbnail,
    this.user,
  });

  factory Poster.fromJson(Map<String, dynamic> json){
    return Poster(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      title: json['title'] == null ? '' : json['title'] as String,
      thumbnail: json['thumbnail'] == null ? '' : json['thumbnail'] as String,
      user: json['user'] == null ? null : json['user'] as User,
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'title' : title,
      'uid' : uid,
      'thumbnail' : thumbnail,
      'user' : user!.toMap(),
    };
  }

}