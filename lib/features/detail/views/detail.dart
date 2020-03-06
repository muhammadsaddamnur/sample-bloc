import 'package:flutter/material.dart';
import 'package:samplebloc/core/ui/ui_text.dart';

class Detail extends StatelessWidget {
  final String id, userId, title, body;

  Detail({this.id, this.userId, this.title, this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UiTextSuperShadow(text: 'Dibuat Oleh : ' + userId),
              UiTextTitle(
                text: title,
              ),
              SizedBox(height: 10),
              UiTextSubTitle(text: body)
            ]),
      )),
    );
  }
}
