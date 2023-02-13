import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HelpScreen extends StatelessWidget {
  static String routeName = "HelpScreen";
  final _xFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Center(
        child: Form(
          child: ListView( 
            children: <Widget>[
              Text("Write feedback/questions!", style:  Theme.of(context).textTheme.displayMedium,),
	            TextFormField(decoration: 
    	          InputDecoration(labelText: "email address", labelStyle: TextStyle(color: Colors.white)),
    	          textInputAction: TextInputAction.next,  maxLines: 3,
    	          onFieldSubmitted: (val) {FocusScope.of(context).requestFocus(_xFocusNode);}
              ),
              TextFormField(
                decoration:InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: "topic " ,helperStyle: TextStyle(color: Colors.white),
                ), 
    	          keyboardType: TextInputType.number, 
                focusNode: _xFocusNode
              ),
              TextFormField(
                decoration:InputDecoration(labelStyle: TextStyle(color: Colors.white),labelText: "content " ,helperStyle: TextStyle(color: Colors.white)), 
    	          keyboardType: TextInputType.number, 
                focusNode: _xFocusNode
              ),
              Row(children: <Widget> [Text("test", style:  Theme.of(context).textTheme.displayMedium)])
            ]
          ),
        )
      )
    );
  }
  @override
  void dispose(){
	  _xFocusNode.dispose();
    //super.dispose();
}
}