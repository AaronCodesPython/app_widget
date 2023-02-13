import 'dart:async';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import "./AskBirthDay.dart" as AB;
import "./settingsScreen_template.dart" as SSC;
import "./main.dart" as MAIN;
import 'package:home_widget/home_widget.dart';

double? yearsLeft;

//TODO: make it work for double values
//ToDO: make background Callback work
void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  print("Our background job ran!");
}

Future<void> backgroundCallback(Uri? uri) async {
  //print("backgroundCallback");
  if (uri?.host == 'updateyearsLeft') {
    // print("reached2");
    double _val;
    await HomeWidget.getWidgetData<double>('yearsLeft', defaultValue: 0)
        .then((value) {
      _val = value!;
      // print("set years left to : $value");
    });
    await HomeWidget.saveWidgetData<double>('yearsLeft', yearsLeft);
    await HomeWidget.updateWidget(
        //this must the class name used in .Kt
        name: 'HomeScreenWidgetProvider',
        iOSName: 'HomeScreenWidgetProvider');
  }
}

class TimerWidget extends StatefulWidget {
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  String? percentDone;
  @override
  void initState() {
    super.initState();
  }

  Future<void> updateAppWidget() async {
    //print("updateAppWidget");
    await HomeWidget.saveWidgetData<String>('yearsLeft', yearsLeft.toString());
    //print("yearsLeft:$yearsLeft");
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    if (mounted) {
      idk().then((value) {
        setState(() {
          yearsLeft = double.parse(value[0]);
          //print(value[0])

          percentDone = value[1];
        });
        updateAppWidget();
        //print(MAIN.yearsLeft);
      });
    }

    return Container(
      child: Column(
        children: [
          SSC.isChecked
              ? Text(
                  yearsLeft == null ? "" : "${yearsLeft.toString()} years left",
                  style: Theme.of(context).textTheme.displayLarge)
              : SizedBox(
                  height: 0,
                  width: 0,
                ),
          SSC.isChecked2
              ? Text(
                  percentDone == null
                      ? ""
                      : "${percentDone.toString()} percent lived",
                  style: Theme.of(context).textTheme.displayLarge)
              : SizedBox(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  Future<List<String>> idk() async {
    DateTime? date;
    DateTime dateToday = DateTime.now();

    String? returnVal = await AB.read(context);
    if (returnVal == null) {
      throw Exception(
          "Return Value is null, which means the file has not been created yet.");
    }
    List<String> numbers = returnVal.split("/");
    date = DateTime(
        int.parse(numbers[2]), int.parse(numbers[0]), int.parse(numbers[1]));

    int wholetime = 2564055000000;

    DateTime approxDeath = DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + wholetime);

    int TimeLeft =
        approxDeath.millisecondsSinceEpoch - dateToday.millisecondsSinceEpoch;

    return [
      ((TimeLeft / 31536000000).toStringAsFixed(8)),
      (100 - ((TimeLeft / wholetime) * 100)).toStringAsFixed(7)
    ];

    return [];
  }
}
