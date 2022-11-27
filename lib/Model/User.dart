
class MyUser{
  final String? name;
  final String? uid;
  final String? profile;
  MyUser({
    this.name,
    this.uid,
    this.profile,
  });

  factory MyUser.fromJson(Map<String, dynamic> json){
    return MyUser(
      uid: json['uid'] == null ? '' : json['uid'] as String,
      name: json['name'] == null ? '' : json['name'] as String,
      profile: json['profile'] == null ? '' : json['profile'] as String,
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'name' : name,
      'uid' : uid,
      'profile' : profile,
    };
  }
}