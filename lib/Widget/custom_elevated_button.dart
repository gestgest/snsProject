import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {

  final String text;

  const CustomElevatedButton({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: (){}, // 첫 페이지에서 성공적으로 로그인 완료 시 이동할 메인 페이지로 네비게이터 푸쉬 사용
          child: Text("$text")),
    );
  }
}