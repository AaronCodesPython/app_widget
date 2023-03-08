import 'package:flutter/material.dart';
import "./UpdateWidget.dart" as upd;
import "./settingsscreen_template.dart" as ssc;

double? yearsL;
double? percentDone;
var prefs;

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

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
    if (ssc.loadPref(name: "isChecked") == null) {
      ssc.loadPref(name: "isChecked", val: true, mode: ssc.Mode.write);
      ssc.loadPref(name: "isChecked2", val: true, mode: ssc.Mode.write);
    }

    upd.updateWidget().then((value) {
      setState(() {
        yearsL = value[0];
        percentDone = value[1];
      });
    });

    return Column(
      children: [
        FutureBuilder(
            future: ssc.loadPref(name: "isChecked", mode: ssc.Mode.read),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!
                    ? Text(
                        yearsL == null
                            ? "loading..."
                            : "${yearsL.toString()} years left",
                        style: Theme.of(context).textTheme.displayLarge)
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      );
              } else {
                return const Text("loading...");
              }
            }),
        FutureBuilder(
            future: ssc.loadPref(name: "isChecked2", mode: ssc.Mode.read),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return snapshot.data!
                    ? Text(
                        yearsL == null
                            ? "loading..."
                            : "${percentDone.toString()} percent done",
                        style: Theme.of(context).textTheme.displayLarge)
                    : const SizedBox(
                        height: 0,
                        width: 0,
                      );
              } else {
                return const Text("loading...");
              }
            }),
      ],
    );
  }
}
