import 'package:flutter/material.dart';
import "./SettingsButtonElement.dart";
import "./HelpScreend.dart";
import 'settingsScreen_template.dart';

Future<dynamic> CustomBottomWidget(BuildContext context) {
  Map<String, Function> options = {
    "Settings": () =>
        Navigator.pushReplacementNamed(context, SettingsScreen.routeName),
    "Help": () => Navigator.pushReplacementNamed(context, HelpScreen.routeName),
    "About the creator": () {}
  };
  List<Widget> g = [];
  options.forEach(
    (key, value) {
      g.add(const SizedBox(height: 16));
      g.add(SettingsButtonElement(key, value));
    },
  );
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.4,
          child: Container(
            height: 200,
            color: Color.fromRGBO(27, 36, 48, 1).withOpacity(0.95),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: g,
              ),
            ),
          ),
        );
      });
}
