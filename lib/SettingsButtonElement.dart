// ignore: file_names
import 'package:flutter/material.dart';

class SettingsButtonElement extends StatelessWidget {
  String text;
  Function func;
  SettingsButtonElement(this.text, this.func, {super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
      child: OutlinedButton(
        onPressed: () {
          func();
        },
        style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color.fromRGBO(38, 38, 38, 1),
            textStyle: const TextStyle(fontSize: 20),
            minimumSize: const Size(200, 70)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text),
          ],
        ),
      ),
    );
  }
}
