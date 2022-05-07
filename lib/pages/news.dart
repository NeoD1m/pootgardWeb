import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../globals.dart' as globals;

class News extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Text("Сайт в разработке\nВерсия: ${globals.buildVersion}",
            style: GoogleFonts.jost(
                //fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.white)),
      ),
    );
  }
}
