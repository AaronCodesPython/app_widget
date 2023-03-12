import 'package:flutter/material.dart';
import "./settingsscreen_template.dart" as ssc;
import "./centerTextcomponent.dart";

class MainTextBox extends StatelessWidget {
  final double? yearsL;
  final double? percentDone;
  final ShownValue shownValue;
  final String? nameProp;
  const MainTextBox(this.shownValue, {super.key, this.yearsL, this.percentDone, this.nameProp});

  

  @override
  Widget build(BuildContext context) {
    var ye = shownValue == ShownValue.year? yearsL : percentDone;
    String text = shownValue == ShownValue.year? "Years Left" : "Percent done";
    return Container(
      decoration: const BoxDecoration(color: Color.fromRGBO(31, 30, 29,1),), margin: EdgeInsets.all(16),
      child: Container(
        margin: const EdgeInsets.all(24),
        child: FutureBuilder(
                future: ssc.loadPref(name: nameProp, mode: ssc.Mode.read),
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!
                        ? Center(
                          child: Text(
                              ye == null
                                  ? "loading..."
                                  : "${ye.toString()} $text",
                              style: Theme.of(context).textTheme.displayLarge),
                        )
                        : const SizedBox(
                            height: 0,
                            width: 0,
                          );
                  } else {
                    return const Text("loading...");
                  }
                }),
      ),
    );
  }
}