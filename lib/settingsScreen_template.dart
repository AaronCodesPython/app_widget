import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ask_birthday.dart';
import "./Setttings_swtich.dart";

var prefs;

enum Mode { write, read }

Future<bool> loadPref({bool? val, String? name, Mode? mode}) async {
  prefs = await SharedPreferences.getInstance();
  if (mode == Mode.write) {
    if (prefs.getBool(name) == null) {
      prefs.setBool(name, true);
      return false;
    }
    await prefs.setBool(name, val);
    return false;
  } else {
    return prefs.getBool(name) ?? true;
  }
}

class SettingsScreen extends StatefulWidget {
  static String routeName = "SettingsScreen";

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(children: [
          TextButton(
            onPressed: () {
              askBirtday(context);
            },
            style: const ButtonStyle(),
            child: const Text(
              "Change Birthday",
              style: TextStyle(color: Colors.white),
            ),
          ),
          SettingsSwitch("isChecked", "years left"),
          SettingsSwitch("isChecked2", "percent lived")
        ]),
      ),
    );
  }
}
