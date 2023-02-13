import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class SettingsButtonElement extends StatelessWidget {
  String text;
  Function func;
  SettingsButtonElement(this.text, this.func);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
        child: OutlinedButton(
          onPressed: (){func();}, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            Text(text),
          ],
        ), 
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Color.fromRGBO(38, 38, 38, 1),
          primary: Colors.white,
          textStyle: TextStyle(fontSize: 20),
          minimumSize: Size(200, 70)
        ),
        ),
    );
  }
}