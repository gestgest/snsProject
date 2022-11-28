
class MyUser{
  final String? name;
  final String? uid;
  final String? profile;
  List<String>? friends; //uid
  MyUser({
    this.name,
    this.uid,
    this.profile,
    this.friends,
  });

  factory MyUser.fromJson(Map<String, dynamic> json){
    MyUser user = MyUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      name: json['name'] == null ? '' : json['name'] as String,
      profile: json['profile'] == null ? '' : json['profile'] as String,
    );
    List<String> myfriends = [];
    for(String s in json['friends']){
      myfriends.add(s);
    }
    user.friends = myfriends;
    //print(list.toString());
    return user;
  }
  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'uid' : uid,
      'profile' : profile,
      'friends' : friends,
    };
  }
}