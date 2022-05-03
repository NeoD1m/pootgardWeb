import 'dart:convert';
import 'dart:html';

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
        return Center(
          child: Column(
            children: [
              Text(
                "YOUR NAME IS $username",
                style: TextStyle(fontSize: 40),
              ),
              Text(
                "YOUR EMAIL IS $email",
                style: TextStyle(fontSize: 30),
              ),
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
              FlatButton(
                  onPressed: () {
                    uploadFile(context,username);
                    setState(() {});
                  },
                  child: Text("Upload skin")),
              FlatButton(onPressed: () {
                (context as Element).reassemble();
                setState((){});
                    } , child: Text("обновить"))
            ],
          ),
        );
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