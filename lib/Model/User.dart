class User{
  String? name;
  String? uid;
  String? profile;
  User({
    this.name,
    this.uid,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
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