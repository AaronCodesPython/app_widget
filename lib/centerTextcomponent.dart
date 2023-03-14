import 'package:flutter/material.dart';
import "./UpdateWidget.dart" as upd;
import "./settingsscreen_template.dart" as ssc;
import "./MainTextBox.dart";

double? yearsL;
double? percentDone;
var prefs;
bool isCheckedVal = false;
bool isCheckedVal2 = false;

enum ShownValue { year, percent }

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
    ssc.loadPref(name: "isChecked", mode: ssc.Mode.read).then((value) {
      isCheckedVal = value;
      if (isCheckedVal == null) {
        ssc.loadPref(name: "isChecked", val: true, mode: ssc.Mode.write);
      }
    });

    ssc.loadPref(name: "isChecked2", mode: ssc.Mode.read).then((value) {
      isCheckedVal2 = value;
      if (isCheckedVal2 == null) {
        ssc.loadPref(name: "isChecked2", val: true, mode: ssc.Mode.write);
      }
    });

    upd.updateWidget().then((value) {
      setState(() {
        yearsL = value[0];
        percentDone = value[1];
      });
    });

    return Center(
      child: Column(
        children: [
          isCheckedVal
              ? MainTextBox(
                  ShownValue.year,
                  yearsL: yearsL!,
                  nameProp: "isChecked",
                  percentDone: percentDone,
                )
              : const SizedBox(width: 0, height: 0),
          isCheckedVal2
              ? MainTextBox(ShownValue.percent,
                  yearsL: yearsL!,
                  nameProp: "isChecked2",
                  percentDone: percentDone)
              : const SizedBox(width: 0, height: 0)
        ],
      ),
    );
  }
}
