import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void askBirtday(BuildContext context) async {
  final dateController = TextEditingController();
  bool bset = await birtdaySet(context);
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
              title: const Text("Hey New User!"),
              content: const Text("Please enter your birthday to continue!"),
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
                            child: const Text("Cancel"),
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/", (route) => false);
                            })
                        : const SizedBox(height: 0, width: 0),
                    TextButton(
                        child: const Text("Submit"),
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

Future<bool> birtdaySet(BuildContext context) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/date_saved.txt');
    String text = await file.readAsString();
    return true;
  } catch (e) {
    return false;
  }
}

Future<String?> read() async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/date_saved.txt');
    String text = await file.readAsString();
    return text;
  } catch (e) {
    //if(e.toString().contains("PathNotFoundException")){
    //AskBirtday(context);
    //}
    return null;
  }
}

_save(String text) async {
  final directory = await getApplicationDocumentsDirectory();
  final file = File('${directory.path}/date_saved.txt');
  await file.writeAsString(text);
}


//TODO: dateController.dispose();