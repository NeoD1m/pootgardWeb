import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../authState.dart';
class LostPassword extends StatelessWidget{
  LostPassword(this.changeState);
  Function changeState;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text("THIS WILL BE PASSWORD REQUEST PAGE",style: TextStyle(color: Colors.white),),
          FlatButton(onPressed: () { changeState(authState.login); },
            child: Text("fuck go back"),)
        ],
      ),
    );
  }

}