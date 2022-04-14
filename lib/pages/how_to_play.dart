import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HowToPlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: const Text(
              "1) Зарегайся/залогинся на сайте\n"
              "2) установи скин\n"
              "3) скачай лаунчер\n"
              "4) залогинся в лаунчере\n"
              "5) играй",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Container(
            height: 200,
            width: 400,
            child: TextButton(
                onPressed: () => {downloadFile("https://launcher.pootgard.fun/EuphoriaLauncher.exe")},
                child: Text("Скачать Лаунчер СОСИ2",style: TextStyle(fontSize: 30),)),
          )
        ],
      ),
    );
  }

  downloadFile(url) {
    AnchorElement anchorElement = new AnchorElement(href: url);
    anchorElement.download = "Euphoria Launcher.exe";
    anchorElement.click();
  }
}
