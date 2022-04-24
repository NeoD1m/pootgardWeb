import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pootgard_web/colors.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 600,
              margin: EdgeInsets.only(bottom: 100),
              child: ElevatedButton(
                  style: TextButton.styleFrom(
                      primary: CoolColors.buttonTextColor,
                      backgroundColor: CoolColors.buttonColor// Text Color
                  ),
                  onPressed: () => {downloadFile("https://launcher.pootgard.fun/Euphoria%20Launcher.exe")},
                  child: Text("Скачать Лаунчер",style: TextStyle(fontSize: 30),)),
            ),
            Container(
              child: Text(
                "1) Зарегайся/залогинся на сайте\n"
                "2) установи скин\n"
                "3) скачай лаунчер\n"
                "4) залогинся в лаунчере\n"
                "5) играй",
                style: GoogleFonts.roboto(fontSize: 40.0,color: CoolColors.textColor)//(fontSize: 40.0,color: CoolColors.textColor),
              ),
            ),

          ],
        ),
      ),
    );
  }

  downloadFile(url) {
    AnchorElement anchorElement = new AnchorElement(href: url);
    anchorElement.download = "Euphoria Launcher.exe";
    anchorElement.click();
  }
}
