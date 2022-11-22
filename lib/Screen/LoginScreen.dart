import 'package:flutter/material.dart';
import 'SignUpScreen.dart';
import 'custom_text_form_field.dart';
import 'custom_elevated_button.dart';

class LoginScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 10),
            CircleAvatar(backgroundImage: AssetImage('res/img/doggy.gif'), radius: 100.0,),
            SizedBox(height: 20),
            CustomTextFormField(hint: "이메일을 입력하세요."), // 텍스트 폼
            CustomTextFormField(hint: "비밀번호를 입력하세요."),
            CustomElevatedButton(text: "로그인"), // 버튼 폼
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUpScreen()
                    ));
                  },
                  child: Text("회원 가입")),
            ),
          ],
        )
      )
    );
  }
}



