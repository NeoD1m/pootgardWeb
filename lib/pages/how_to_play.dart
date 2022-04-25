import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pootgard_web/colors.dart';

class HowToPlay extends StatefulWidget {
  @override
  State<HowToPlay> createState() => HowToPlayState();
}

class HowToPlayState extends State<HowToPlay> {
  final List<bool> _isPanelOpen = List.filled(4, false);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.backgroundColor,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
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
                        backgroundColor: CoolColors.buttonColor // Text Color
                        ),
                    onPressed: () => {
                          downloadFile(
                              "https://launcher.pootgard.fun/Euphoria%20Launcher.exe")
                        },
                    child: const Text(
                      "Скачать Лаунчер",
                      style: TextStyle(fontSize: 30),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(left: 500,right: 500),
                child: ExpansionPanelList(
                  //elevation: 0,
                  //expandedHeaderPadding: EdgeInsets.only(top: 100),
                  //dividerColor: CoolColors.mainColor,
                  children: [
                    CoolExpansionPanel(0,"Регистрация"),
                    CoolExpansionPanel(1,"Базовые игровые механики"),
                    CoolExpansionPanel(2,"Хз что сюда написать"),
                    CoolExpansionPanel(3,"тем более сюда"),
                  ],
                  expansionCallback: (i, isOpen) => setState(() {
                    _isPanelOpen[i] = !_isPanelOpen[i];
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  ExpansionPanel CoolExpansionPanel(int num,String theme){

    return ExpansionPanel(
        backgroundColor: CoolColors.textColor,
        canTapOnHeader: true,
        headerBuilder: (context, isOpen) {
          return Container(
            margin: const EdgeInsets.only(left: 20),
              child: Text(theme,style: GoogleFonts.roboto(
                  fontSize: 40.0,
                  color: Colors.black) ,));
        },
        body: FlatButton(
          //color: Colors.pinkAccent,
          onPressed: () { _isPanelOpen[num] = false; setState(() {

          }); },
          child: Text(
              "1) Зарегайся/залогинся на сайте\n"
                  "2) установи скин\n"
                  "3) скачай лаунчер\n"
                  "4) залогинся в лаунчере\n"
                  "5) играй",
              style: GoogleFonts.roboto(
                  fontSize: 40.0,
                  color: Colors.black) //(fontSize: 40.0,color: CoolColors.textColor),
          ),
        ),
        isExpanded: _isPanelOpen[num]);
  }
  downloadFile(url) {
    AnchorElement anchorElement = AnchorElement(href: url);
    anchorElement.download = "Euphoria Launcher.exe";
    anchorElement.click();
  }
}
