import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:snsproject/Service/UserService.dart';
import 'package:snsproject/main.dart';

import '../Model/MyUser.dart';
import '../firestorage_repository.dart';
import 'HomeScreen.dart';
class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final ImagePicker _picker = ImagePicker();
  final FirestorageRepository storage = FirestorageRepository();
  XFile? thumbnailXfild;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  TextEditingController nameController = TextEditingController();
  XFile? _pickedFile;
  String? loadImgUrl;
  String? profileAddress;

  void update() => setState(() {});
  @override
  Widget build(BuildContext context) {
    
    return Consumer<UserService>(builder: (context, userService, child) {
      return FutureBuilder(
        future: userService.readUid(uid),
        builder: (BuildContext context, AsyncSnapshot<MyUser> user) {
          if (!user.hasData)
          {
            return CustomScrollView(
              slivers : [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: _imagebody()),
                        Container(
                          width: 300,
                          child: TextField(
                              style: TextStyle(color: Colors.black, fontFamily: "DJ"),
                              controller: nameController,
                              decoration: InputDecoration(
                                hintText: "?????????",
                                hintStyle:
                                TextStyle(color: Colors.black),

                              )
                          ),
                        ),
                        Center(
                          child: ElevatedButton(onPressed: () {
                            if(nameController.text.isEmpty)
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("???????????? ????????? ?????????"),
                              ));
                            else{
                              //?????? ?????????
                              _showAlert(userService, uid);
                            }

                          }, child: Text("??????")),
                        )

                      ],
                    ),

                ),
              ],
            );
          }
          //?????? ???????????? ?????????
          else{
            return HomePage();
          }
          if (user.connectionState == ConnectionState.waiting ||
              !user.hasData) {
            return CircularProgressIndicator(); //?????????
          }
        },
      );
    });
  }

  void _showAlert(UserService us, String uid) {
    // ?????? ?????? ?????? ???????????????
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("?????????????????????????"),
            actions: [
              CupertinoDialogAction(
                //?????? ??????
                  isDefaultAction: true,
                  child: Text("??????"),
                  onPressed: () async {
                    //?????? ????????? ???????????? ??????
                    //ps, user
                    List<String> friends = [];
                    //?????? ?????????
                    String ss = "https://firebasestorage.googleapis.com/v0/b/snsprojectfb.appspot.com/o/poster%2F8ovh47lzzTViQspJde0Q%2Fthumbnail%2Fimage.jpg?alt=media&token=6441819d-2a13-4832-98e9-fb83fbff7ab0";
                    MyUser user = MyUser(friends : friends, name : nameController.text, profile: ss, uid : uid);
                    String id = await us.create(user);
                    //????????? address ????????? ????????? ??????

                    //???
                    Navigator.pop(context);
                    sendImageToFireStorage(uid);
                    loadCreate(us, user, id);



                  }),
              CupertinoDialogAction(
                //?????? ?????????
                  isDefaultAction: true,
                  child: Text("??????"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
  Future<void> loadCreate(UserService us,MyUser user,String id ) async
  {

    Future.delayed(
        const Duration(milliseconds: 100),
            () {
          if (loadImgUrl != null) {

            user.profile = loadImgUrl;
            us.updateId(user, id);
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (_) => false);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
            Navigator.pushNamedAndRemoveUntil(
                context, '/', (_) => false);
            loadImgUrl = null;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("??????????????? ${nameController.text}???!"),
            ));
          }
          else
            loadCreate(us,user,id);
        }
    );

  }

  Future<void> sendImageToFireStorage(String uid) async {
    XFile? pickedFile = _pickedFile;
    if (pickedFile != null || uid != null) {
      //url ????????? ??????
      loadImgUrl = await storage.uploadFile(pickedFile!.path, "user/"+uid+"/profile.png");
      // FireStorage??? ??????????????? ?????????
    }
  }

  Widget _imageCard() {
    // ???????????? ????????? ????????? ?????? ??? ??? ????????? ?????????
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _imagebody() {
    if (_pickedFile != null) {
      return _imageCard(); // pickedFiles != null
    } else {
      return _uploaderCard(); // pickedFiles == null
    }
  }
  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
  Widget _menu() {
    //????????? ????????? ?????? ??????
    return FloatingActionButton(
      onPressed: () {
        _clear();
      },
      backgroundColor: Colors.redAccent,
      tooltip: 'Delete',
      child: const Icon(Icons.delete),
    );
  }

  Widget _uploaderCard() {
    //????????? ????????? ?????? ??? ??? ????????? ?????????
    return Center(
      child: Card(
        color: Colors.white,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.8),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.9),
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Upload an image to start',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(
                                color: Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.9)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                //????????? ??????
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontFamily: "DJ", fontSize: 15)),
                  child: const Text('Upload'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _uploadImage() async {
    final pickedfile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        //?????? pickedFiles
        _pickedFile = pickedfile;
      });
    }
  }

//????????? ?????? ?????????
  void _clear() {
    setState(() {
      _pickedFile = null;
    });
  }

}
