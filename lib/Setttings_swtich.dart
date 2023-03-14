import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './settingsScreen_template.dart';

class SettingsSwitch extends StatelessWidget {
  final String? nameProp;
  final String? shownText;
  const SettingsSwitch(this.nameProp, this.shownText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
            future: loadPref(val: null, mode: Mode.read, name: nameProp),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                return CupertinoSwitch(
                  value: snapshot.data!,
                  onChanged: (val) {
                    loadPref(val: val, name: nameProp, mode: Mode.write);
                    //isChecked = !isChecked;
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
          "$shownText",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    );
  }
}
