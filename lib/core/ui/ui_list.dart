import 'package:flutter/material.dart';

class UiList1 extends StatelessWidget {
  final String text;
  final Function onTap;

  UiList1({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      )),
    );
  }
}
