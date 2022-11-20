import 'package:flutter/material.dart';
import 'package:snsproject/Screen/UploadPosterScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'snsProject',
      home: UploadPosterScreen(),
    );
  }
}
