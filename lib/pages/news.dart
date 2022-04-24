import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../globals.dart' as globals;
class News extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text("Бета-тест\nВерсия сайта: ${globals.buildVersion}",style: TextStyle(color: Colors.amber,fontSize: 40),),
      ),
    );
  }

}
