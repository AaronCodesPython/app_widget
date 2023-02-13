import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

import "./AskBirthDay.dart";

bool isChecked = true;
bool isChecked2 = false;

class SettingsScreen extends StatefulWidget {
  static String routeName = "SettingsScreen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            child: ListView(children: [
          TextButton(
            onPressed: () {
              AskBirtday(context);
            },
            child: Text(
              "Change Birthday",
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(),
          ),
          Row(
            children: [
              CupertinoSwitch(
                value: isChecked,
                onChanged: (val) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                trackColor: Color.fromRGBO(38, 38, 38, 1),
              ),
              SizedBox(
                width: 30,
                height: 0,
              ),
              Text(
                "Show years",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ],
          ),
          Row(children: [
            CupertinoSwitch(
              value: isChecked2,
              onChanged: (val) {
                setState(() {
                  isChecked2 = !isChecked2;
                });
              },
              trackColor: Color.fromRGBO(38, 38, 38, 1),
            ),
            SizedBox(
              width: 30,
              height: 0,
            ),
            Text(
              "Show percentage",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ]),
        ])),
      ),
    );
  }
}
