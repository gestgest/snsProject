
import 'User.dart';

class Story{
  final String? image;
  final User? user;
  final DateTime? time;
  Story({
    this.image,
    this.user,
    this.time,
  });

  factory Story.fromJson(Map<String, dynamic> json){
    return Story(
      image: json['image'] == null ? '' : json['image'] as String,
      user: json['user'] == null ? null : json['user'] as User,
      time: json['time'] == null ? null : json['time'] as DateTime,
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'image' : image,
      'user' : user,
      'time' : time,
    };
  }
}