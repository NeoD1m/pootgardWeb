import 'package:flutter/cupertino.dart';
import 'package:webviewx/webviewx.dart';

import '../colors.dart';

class WorldMap extends StatelessWidget{
  late WebViewXController webViewController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.mainColor,
      child: WebViewX(
          height: double.maxFinite,
          width: double.maxFinite,
          initialContent: '<h2> Что то пошло не по плану </h2>',
          initialSourceType: SourceType.html,
          onWebViewCreated: (controller) => {webViewController = controller,
            webViewController.loadContent('https://map.pootgard.fun/', SourceType.url,)}),
    );
  }
}