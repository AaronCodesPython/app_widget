import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  static String routeName = "HelpScreen";
  final _xFocusNode = FocusNode();

  HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Form(
          child: ListView(children: <Widget>[
            Text(
              "Write feedback/questions!",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            TextFormField(
                decoration: const InputDecoration(
                    labelText: "email address",
                    labelStyle: TextStyle(color: Colors.white)),
                textInputAction: TextInputAction.next,
                maxLines: 3,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_xFocusNode);
                }),
            TextFormField(
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.white),
                  labelText: "topic ",
                  helperStyle: TextStyle(color: Colors.white),
                ),
                keyboardType: TextInputType.number,
                focusNode: _xFocusNode),
            TextFormField(
                decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    labelText: "content ",
                    helperStyle: TextStyle(color: Colors.white)),
                keyboardType: TextInputType.number,
                focusNode: _xFocusNode),
            Row(children: <Widget>[
              Text("test", style: Theme.of(context).textTheme.displayMedium)
            ])
          ]),
        )));
  }

  void dispose() {
    _xFocusNode.dispose();
    //super.dispose();
  }
}
