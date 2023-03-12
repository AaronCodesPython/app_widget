import 'package:flutter/material.dart';
import "./UpdateWidget.dart" as upd;
import "./settingsscreen_template.dart" as ssc;
import "./MainTextBox.dart";
double? yearsL;
double? percentDone;
var prefs;

enum ShownValue{
  year, percent    
}

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

    return Center(
      child: Column(
        children: [
          MainTextBox(ShownValue.year, yearsL:yearsL!,nameProp: "isChecked", percentDone: percentDone,),
          MainTextBox(ShownValue.percent, yearsL: yearsL!,nameProp: "isChecked2", percentDone: percentDone)
        ],
      ),
    );
  }
}
