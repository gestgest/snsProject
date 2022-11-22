import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final String hint;

  const CustomTextFormField({required this.hint});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        obscureText: hint == "비밀번호를 입력하세요." ? true : false,
        decoration: InputDecoration(
            hintText: "$hint",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
    );
  }
}