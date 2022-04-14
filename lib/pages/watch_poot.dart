import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class WatchPoot extends StatelessWidget{
  final String _markdownData = "# Наш покровитель\n## Сервер создан при поддержке Дмитрия MightyPoot, залейтайте на его [стримы](https://www.twitch.tv/mightypoot)";

  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width*0.3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          //color: Colors.yellow,
          width: cWidth,
          height: cWidth/2,
          child: Markdown(
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(textScaleFactor: 1.7),
            controller: controller,
            selectable: true,
            data: _markdownData,
            onTapLink: (text, url, title){
              launch(url!);
            },
          ),
        ),
        SizedBox(
          //width: cWidth,
            child: Image.network("https://st.wasd.tv/upload/avatars/c439754c-f461-41d0-8233-59f228edafc5/original.jpeg"))
      ],
    );
  }

}