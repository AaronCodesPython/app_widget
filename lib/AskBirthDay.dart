import './centerTextcomponent.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void AskBirtday(BuildContext context) async {
  final dateController = TextEditingController();
  bool bset = await BirtdaySet(context);
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
              title: Text("Hey New User!"),
              content: Text("Please enter your birthday to continue!"),
              actions: <Widget>[
                TextField(
                  readOnly: true,
                  controller: dateController,
                  decoration: const InputDecoration(hintText: 'Pick your Date'),
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    if (date != null) {
                      dateController.text =
                          DateFormat('MM/dd/yyyy').format(date);
                    }
                  },
                ),
                Row(
                  children: [
                    bset
                        ? TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
                            })
                        : SizedBox(height: 0, width: 0),
                    TextButton(
                        child: Text("Submit"),
                        onPressed: () {
                          String date = dateController.text;
                          _save(date);
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => false);
                          //read(context);
                        })
                  ],
                )
              ]));
}

Future<bool> BirtdaySet(BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/date_saved.txt');
    String text = await file.readAsString();
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

read(BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/date_saved.txt');
    String text = await file.readAsString();
    return text;
  } catch (e) {
    print(e);
    print("no birthday set");
    //if(e.toString().contains("PathNotFoundException")){
    //print("ASKS AGAIN");
    //AskBirtday(context);
    //}
    return null;
  }
}

_save(String text) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/date_saved.txt');
  print("PATH:${directory.path}/date_saved.txt");
  await file.writeAsString(text);
  print('saved');
}


//TODO: dateController.dispose();