import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/MyUser.dart';
import '../Service/UserService.dart';

class AddFriendWidget extends StatefulWidget {
  MyUser user;

  AddFriendWidget({Key? key, required this.user}) : super(key: key);

  _AddFriendState createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriendWidget> {
  @override
  //widget.user
  //친구 비교
  //
  Widget build(BuildContext context) {
    String myuid = FirebaseAuth.instance.currentUser!.uid;
    return Consumer<UserService>(builder: (context, userService, child) {
      return FutureBuilder(
          future: userService.readUid(myuid),
          builder: (BuildContext context, AsyncSnapshot<MyUser> snapshot) {
            //return Container();
            bool isFriend = false;
            if (snapshot.data == null) return Container();
            //친구비교
            //print("ppp "+ snapshot.data.toString() + widget.user.name!);
            for (String uid in snapshot.data!.friends!) {
              if (widget.user.uid == uid) {
                isFriend = true;
              }
            }
            print("실행");
            return isFriend ? Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: SizedBox(
                      width: 65,
                      height: 65,
                      child: Image(
                        image: NetworkImage(widget.user.profile!),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    onPressed: () {
                      //
                      print("삭제" + widget.user.uid!);
                      snapshot.data!.friends!.remove(widget.user.uid);
                      userService.update(snapshot.data!);
                    },
                    child: Text("친구 삭제"))
              ],
            ): Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(65),
                  child: SizedBox(
                      width: 65,
                      height: 65,
                      child: Image(
                        image: NetworkImage(widget.user.profile!),
                      )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    //친구 추가
                    print("추가" + widget.user.uid!);
                    snapshot.data!.friends!.add(widget.user.uid!);
                    userService.update(snapshot.data!);
                  },
                  child: Text("친구 추가"),
                ),
              ],
            );
          });
    });
  }
}
