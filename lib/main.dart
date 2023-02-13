import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import "./centerTextcomponent.dart" as CTC;
import "./customBottomSheet.dart";
import 'settingsScreen_template.dart';
import "./HelpScreend.dart";

import 'package:flutter/material.dart';

import "./AskBirthDay.dart" as AB;

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized(); //NEW
  //HomeWidget.registerBackgroundCallback(CTC.backgroundCallback);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(textDirection: TextDirection.ltr, children: [
      MaterialApp(
        title: 'Days left',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.black87,
            textTheme: const TextTheme(
                displayMedium: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                displayLarge: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),

        initialRoute: '/', // default is '/'
        routes: {
          '/': (ctx) => const mainComponent(title: 'Days left'),
          SettingsScreen.routeName: (ctx) => SettingsScreen(),
          HelpScreen.routeName: (ctx) => HelpScreen()
        },
      ),
    ]);
  }
}

class mainComponent extends StatefulWidget {
  const mainComponent({super.key, required this.title});
  final String title;

  @override
  State<mainComponent> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<mainComponent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    AB.BirtdaySet(context)
        .then((value) => value ? false : AB.AskBirtday(context));
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              CustomBottomWidget(context);
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: CTC.TimerWidget(),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
