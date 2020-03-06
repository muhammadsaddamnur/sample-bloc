import 'package:flutter/material.dart';

class UiTextTitle extends StatelessWidget {
  final String text;

  UiTextTitle({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    );
  }
}

class UiTextSubTitle extends StatelessWidget {
  final String text;

  UiTextSubTitle({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 15),
    );
  }
}

class UiTextSuperShadow extends StatelessWidget {
  final String text;

  UiTextSuperShadow({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }
}
