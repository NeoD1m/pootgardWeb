import 'dart:convert';
import 'dart:html';

import 'package:Pootgard/colors.dart';
import 'package:flutter/services.dart';
import 'package:universal_html/html.dart' as html;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewx/webviewx.dart';
import '../../user.dart';
import 'auth.dart';
import '../../globals.dart' as globals;
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => ProfileState();
}

String username = "";
String email = "";

Future<void> getData() async {
  username = await getUserName(globals.user.username);
  email = await getUserEmail(globals.user.username);
}

class ProfileState extends State<Profile> {
  late Future<File> file;
  String status = '';
  late String base64Image;
  late File tmpFile;
  String errMessage = 'Error Uploading Image';
  late WebViewXController webViewController;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 500,
                    child: WebViewX(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        initialSourceType: SourceType.html,
                        onWebViewCreated: (controller) => {
                          webViewController = controller,
                          webViewController.loadContent(
                            'https://skins.pootgard.fun/skinviewer/Minecraft-SkinViewer-master/index.php?name=$username',
                            SourceType.url,
                          )
                        }),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// приветствовать по времени суток
                      Text(
                        "Привет, $username",
                        style: TextStyle(fontSize: 40,color: CoolColors.textColor),
                      ),
                      Text(
                        "Email: $email",
                        style: TextStyle(fontSize: 30,color: CoolColors.textColor),
                      ),
                      SizedBox(
                        height: 50,
                        width: 300,
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                                primary: CoolColors.buttonTextColor,
                                backgroundColor: CoolColors.buttonColor // Text Color
                            ),
                            onPressed: () {
                              uploadSkin(context, username,webViewController);
                            },
                            child: const Text(
                              "Загрузить скин",
                              style: TextStyle(fontSize: 20),
                            )),
                      ),
                      // SizedBox(
                      //   height: 50,
                      //   width: 300,
                      //   child: TextButton(
                      //       style: TextButton.styleFrom(
                      //           primary: CoolColors.textColor,
                      //           //backgroundColor: CoolColors.buttonColor // Text Color
                      //       ),
                      //       onPressed: () {
                      //         username = "";
                      //         globals.user = User(email: "", username: "", password: "");
                      //         setState(() {
                      //
                      //         });
                      //       },
                      //       child: const Text(
                      //         "Выйти из аккаунта",
                      //         style: TextStyle(fontSize: 20),
                      //       )),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container(
              color: Colors.black,
              child: Center(
                  child: const CircularProgressIndicator(
                color: Colors.amber,
              )));
        }
      },
    );
  }
}

Future<String> getUserName(String username) async {
  var apiUrl = "https://auth.pootgard.fun/getUserName.php";
  var response = await http.post(
    Uri.parse(apiUrl),
    body: {
      "username": username,
    },
  );
  var data = json.decode(response.body);
  if (data == "") {
    return "ERROR WHILE GETTING USERNAME, CONTACT ADMINS";
  }
  return data;
}

Future<String> getUserEmail(String username) async {
  var apiUrl = "https://auth.pootgard.fun/getUserEmail.php";
  var response = await http.post(
    Uri.parse(apiUrl),
    body: {
      "username": username,
    },
  );
  var data = json.decode(response.body);
  if (data == "") {
    return "ERROR WHILE GETTING EMAIL, CONTACT ADMINS";
  }
  return data;
}
