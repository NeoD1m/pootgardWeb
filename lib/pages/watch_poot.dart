import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

import '../colors.dart';

class WatchPoot extends StatelessWidget {
  late WebViewXController webViewController;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.3;
    return Container(
      color: CoolColors.backgroundColor,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 200),
              //color: Colors.blueAccent,
                width: containerWidth/2,
                //width: cWidth,
                child: Image.network(
                    "https://st.wasd.tv/upload/avatars/c439754c-f461-41d0-8233-59f228edafc5/original.jpeg")),
            Container(
              width: containerWidth,
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Center(
                  child: Text(
                      "Сервер создан при поддержке MightyPoot, залетайте на его стримы.",
                      style: GoogleFonts.jost(
                          //fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                socialButton("Twitch", Colors.purple,"https://www.twitch.tv/mightypoot"),
                socialButton("Youtube", Colors.red,"https://www.youtube.com/DmitriyPoot"),
                socialButton("Discord", Colors.blueAccent,"https://discord.com/invite/RcuGsDcx24"),
                socialButton("Donate", Colors.orange,"https://www.donationalerts.com/r/mightypoot"),
              ],
            )
          ],
        ),
      ),
    );
  }
//https://player.twitch.tv/?channel=mightypoot&parent=www.example.com
}
void _launchUrl(String _url) async {
  if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
}
Widget socialButton(String text, Color color,String url) {
  return Container(
    width: 100,
    height: 100,
    margin: EdgeInsets.only(left: 20, right: 20),
    child: RaisedButton(color: color, onPressed: () {_launchUrl(url);}, child: Text(text,style: GoogleFonts.jost(
        fontWeight: FontWeight.bold,
        //fontSize: 40,
        color: Colors.white))),
  );
}
