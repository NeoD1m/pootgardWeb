import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:pootgard_web/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webviewx/webviewx.dart';

class WatchPoot extends StatelessWidget{
  //final String _markdownData = "<span style='color: red;'># Наш покровитель\n## Сервер создан при поддержке Дмитрия MightyPoot, залейтайте на его [стримы](https://www.twitch.tv/mightypoot)</span>";
  late WebViewXController webViewController;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width*0.3;
    return Container(
      color: CoolColors.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: cWidth,
            height: cWidth/2,
            child: Center(child: Text("Сервер создан при поддержке Дмитрия MightyPoot, залейтайте на его стримы",style: TextStyle(color: Colors.amber,fontSize: 40),)),
            // child: Markdown(
            //   styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
            //       .copyWith(textScaleFactor: 1.7),
            //   controller: controller,
            //   selectable: true,
            //   data: _markdownData,
            //   onTapLink: (text, url, title){
            //     launch(url!);
            //   },
            // ),
          ),
          // Container(
          //   width: 500,
          //   height: 300,
          //   child: WebViewX(
          //       height: double.maxFinite,
          //       width: double.maxFinite,
          //       initialSourceType: SourceType.html,
          //       onWebViewCreated: (controller) => {
          //         webViewController = controller,
          //         webViewController.loadContent(
          //           'https://player.twitch.tv/?channel=mightypoot&parent=www.pootgard.fun',
          //           SourceType.url,
          //         )
          //       }),
          // ),
          SizedBox(
            //width: cWidth,
              child: Image.network("https://st.wasd.tv/upload/avatars/c439754c-f461-41d0-8233-59f228edafc5/original.jpeg"))
        ],
      ),
    );
  }
//https://player.twitch.tv/?channel=mightypoot&parent=www.example.com
}