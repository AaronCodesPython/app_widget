import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ask_birthday.dart';

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
          Row(
            children: [
              FutureBuilder(
                  future:
                      loadPref(val: null, mode: Mode.read, name: "isChecked"),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.hasData) {
                      return CupertinoSwitch(
                        value: snapshot.data!,
                        onChanged: (val) {
                          setState(() {
                            loadPref(
                                val: val, name: "isChecked", mode: Mode.write);
                            //isChecked = !isChecked;
                          });
                        },
                        trackColor: const Color.fromRGBO(38, 38, 38, 1),
                      );
                    } else {
                      return const SizedBox(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
              const SizedBox(
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
            FutureBuilder(
                future:
                    loadPref(val: null, mode: Mode.read, name: "isChecked2"),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return CupertinoSwitch(
                      value: snapshot.data!,
                      onChanged: (val) {
                        setState(() {
                          loadPref(
                              val: val, name: "isChecked2", mode: Mode.write);
                          //isChecked = !isChecked;
                        });
                      },
                      trackColor: const Color.fromRGBO(38, 38, 38, 1),
                    );
                  } else {
                    return const SizedBox(
                      width: 0,
                      height: 0,
                    );
                  }
                }),
            const SizedBox(
              width: 30,
              height: 0,
            ),
            Text(
              "Show percentage",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ]),
        ]),
      ),
    );
  }
}
