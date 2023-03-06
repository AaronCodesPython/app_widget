import 'dart:async';
import 'package:flutter/cupertino.dart';
import "./AskBirthDay.dart" as AB;
import 'package:home_widget/home_widget.dart';
import "./settingsScreen_template.dart" as SSC;
import 'package:shared_preferences/shared_preferences.dart';

double? yearsLeft;
double? percentDone;
BuildContext? context;
var prefs;
Future<bool> getPref(String name) async {
  prefs = await SharedPreferences.getInstance();
  return prefs.getBool(name) ?? true;
}

Future<void> updateAppWidget() async {
  //get Settings
  bool isChecked = await getPref("isChecked");
  bool isChecked2 = await getPref("isChecked2");
  if (isChecked && isChecked2) {
    await HomeWidget.saveWidgetData<String>('yearsLeft',
        "${yearsLeft.toString()} years : ${percentDone.toString()}%"); //!!
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  } else if (isChecked && !isChecked2) {
    await HomeWidget.saveWidgetData<String>(
        'yearsLeft', "${yearsLeft.toString()} years"); //!!
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  } else if (!isChecked && isChecked2) {
    await HomeWidget.saveWidgetData<String>(
        'yearsLeft', "percent done: ${percentDone.toString()} %"); //!!
    await HomeWidget.updateWidget(
        name: 'HomeScreenWidgetProvider', iOSName: 'HomeScreenWidgetProvider');
  }
}

Future<List<double?>> UPDATEWIDGET() async {
  //removed if(mounted)

  List<String> data = await idk();
  yearsLeft = double.parse(data[0]);
  percentDone = double.parse(data[1]);
  updateAppWidget();

  return [yearsLeft, percentDone != null ? percentDone! : null];
  //print(MAIN.yearsLeft);
}

Future<List<String>> idk() async {
  DateTime? date;
  DateTime dateToday = DateTime.now();

  String? returnVal = await AB.read();
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
}
