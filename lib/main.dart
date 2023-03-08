import 'package:flutter/material.dart';
import "./centerTextcomponent.dart" as ctc;
import "./customBottomSheet.dart";
import 'settingsScreen_template.dart';
import "./HelpScreend.dart";
import "./UpdateWidget.dart";

import 'ask_birthday.dart' as ab;

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void fireAlarm() async {
  updateWidget();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized(); //NEW
  //HomeWidget.registerBackgroundCallback(CTC.backgroundCallback);
  runApp(const MyApp());
}

void startBackground() async {
  await AndroidAlarmManager.initialize();
  AndroidAlarmManager.periodic(
    const Duration(seconds: 60),
    1,
    fireAlarm,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    startBackground();

    return Stack(textDirection: TextDirection.ltr, children: [
      MaterialApp(
        title: 'Days left',
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(27, 36, 48, 1),
            textTheme: const TextTheme(
                displayMedium: TextStyle(
                    fontSize: 25,
                    fontFamily: "Taner",
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                displayLarge: TextStyle(
                    fontFamily: "Taner",
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(214, 213, 168, 1)))),

        initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => const MainComponent(title: 'Days left'),
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen()
        },
      ),
    ]);
  }
}

class MainComponent extends StatefulWidget {
  const MainComponent({super.key, required this.title});
  final String title;

  @override
  State<MainComponent> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MainComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    ab
        .birtdaySet(context)
        .then((value) => value ? false : ab.askBirtday(context));
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              CustomBottomWidget(context);
            },
            icon: const Icon(Icons.more_horiz),
          ),
        ],
        backgroundColor: Color.fromRGBO(27, 36, 48, 1),
      ),
      body: const Center(
        child: ctc.TimerWidget(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

///////////////////////////////////////////////////
///import 'dart:async';
/*import 'package:flutter/cupertino.dart';
import "./AskBirthDay.dart" as AB;
import 'package:home_widget/home_widget.dart';
*/
