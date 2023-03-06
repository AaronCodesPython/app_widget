import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "./UpdateWidget.dart" as UPD;

double? yearsL;
double? percentDone;
var prefs;

Future<bool> loadPref(String name) async {
  print("loadPref");
  prefs = await SharedPreferences.getInstance();
  print(prefs.getBool(name));
  return await prefs.getBool(name);
}

class TimerWidget extends StatefulWidget {
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UPD.UPDATEWIDGET().then((value) {
      setState(() {
        yearsL = value[0];
        percentDone = value[1];
      });
    });

    return Container(
      child: Column(
        children: [
          FutureBuilder(
              future: loadPref("isChecked"),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                print("SNAPSHOT HAS DATA: ${snapshot.hasData.toString()}");
                if (snapshot.hasData) {
                  return snapshot.data!
                      ? Text(
                          yearsL == null
                              ? "loading..."
                              : "${yearsL.toString()} years left",
                          style: Theme.of(context).textTheme.displayLarge)
                      : SizedBox(
                          height: 0,
                          width: 0,
                        );
                } else {
                  return Text("loading...");
                }
              }),
          FutureBuilder(
              future: loadPref("isChecked2"),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!
                      ? Text(
                          yearsL == null
                              ? "loading..."
                              : "${percentDone.toString()} percent done",
                          style: Theme.of(context).textTheme.displayLarge)
                      : SizedBox(
                          height: 0,
                          width: 0,
                        );
                } else {
                  return Text("loading...");
                }
              }),
        ],
      ),
    );
  }
}
