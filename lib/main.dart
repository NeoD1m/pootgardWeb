import 'dart:html';
import 'dart:ui';

import 'package:Pootgard/pages/how_to_play.dart';
import 'package:Pootgard/pages/map.dart';
import 'package:Pootgard/pages/news.dart';
import 'package:Pootgard/pages/watch_poot.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Pootgard/globals.dart' as globals;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

import 'package:webviewx/webviewx.dart';

import 'colors.dart';
import 'pages/auth/auth.dart';

//                           оно смотрит
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠐⠂⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⡠⠴⠤⣤⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⢀⣀⣀⣀⣀⡀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠀⠈⠉⢁⣈⣿⣿⣿⣷⡀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠠⠴⠒⠛⠛⠛⠛⠛⠛⠛⠷⠄⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⠀⣀⣤⣴⣶⣶⣶⣶⣶⣶⣤⣄⣀⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⣠⣾⣿⠿⠟⠛⠛⠛⠛⠛⠿⠿⣿⣿⣷⣆⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠀⠐⠋⠉⣀⡠⠤⠔⠒⠒⠒⠠⠤⢀⡀⠉⠛⠿⣆⠀⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⢀⣠⠔⠊⠁⠀⢠⣤⣤⣶⣤⣤⣤⡀⠈⠑⠠⢄⠈⠁⠀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠋⠀⢴⠋⠀⠀⠰⣧⠀⢸⣿⣿⣿⣿⣿⣿⡇⠀⣴⣄⠀⠑⠢⣤⡀⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⢀⣄⠀⠀⢾⣦⠀⠙⠦⠀⠙⠿⠿⠿⠿⠋⠀⣴⠋⠁⣀⣤⣠⣿⣷⡀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠁⢀⠀⠙⢷⣶⣾⣿⣷⣤⣄⣰⣦⣄⣀⣀⣠⣴⣾⣿⣷⠾⠿⠀⠈⠉⠛⠓⠀⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⢀⠈⠓⢤⣀⠉⠙⠻⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣅⣀⣠⣤⣄⡀⠀⠒⠲⠶⠄⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠉⠀⠀⠀⠙⠷⣶⣤⣤⣀⣀⣀⡉⠉⣹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣦⣤⣀⣀⣀⠀⠹⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⠏⠀⣰⣿⣷⣄⡀⠙⠢⡀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣆⠀⠹⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣇⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣸⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pootgard',
      theme: ThemeData(
        scaffoldBackgroundColor: CoolColors.upperButtonDeselectedColor,
      ),
      home: const HomePage(title: 'Pootgard'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(
    initialPage: 0,
  );
  var isSelected = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                  //borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                stops: [
                  0.1,
                  0.9,
                ],
                colors: [Colors.amber, Colors.pinkAccent],
              )),
              child: ToggleButtons(
                renderBorder: false,
                borderRadius: BorderRadius.circular(0),
                borderColor: Colors.blue,
                splashColor: CoolColors.upperButtonSelectedColor,
                // крута
                fillColor: CoolColors.upperButtonSelectedColor,
                focusColor: CoolColors.upperButtonSelectedColor,
                selectedColor: CoolColors.upperButtonSelectedTextColor,
                //Colors.white,
                borderWidth: 0,
                children: <Widget>[
                  TopButton(isSelected, "Новости", Icons.fiber_new_sharp, 0),
                  TopButton(isSelected, "Карта", Icons.map_sharp, 1),
                  TopButton(isSelected, "Смотри Пута", Icons.remove_red_eye, 2),
                  TopButton(isSelected, "Как играть?", Icons.help, 3),
                  TopButton(isSelected, "Личный кабинет",
                      Icons.account_circle_sharp, 4),
                ],
                onPressed: (int index) {
                  setState(() {
                    controller.animateToPage(index,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut);
                    isSelected = [false, false, false, false, false];
                    isSelected[index] = !isSelected[index];
                  });
                },
                isSelected: isSelected,
              )),
          Pages(controller),
          Expanded(
            flex: 1,
            child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(-0.1, 11),
                    stops: [0.0, 0.5, 0.5, 1],
                    colors: [
                      Colors.black,
                      Colors.black,
                      Colors.orange,
                      Colors.orange,
                    ],
                    tileMode: TileMode.repeated,
                  ),
                ),
                child: const Center(
                    child: Text(
                  "WORK IN PROGRESS",
                  style: TextStyle(fontSize: 45, color: Colors.white),
                ))),
          ),
        ],
      ),
    );
  }
}

class TopButton extends StatelessWidget {
  var isSelected;
  String text;
  IconData icon;
  int num;

  TopButton(this.isSelected, this.text, this.icon, this.num, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          width: MediaQuery.of(context).size.width / isSelected.length,
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: (isSelected[num]) ? getButtonGradientColor(num) : Colors.black,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    text,
                    style: GoogleFonts.jost(
                        fontSize: 25.0,
                        color: (isSelected[num])
                            ? getButtonGradientColor(num)
                            : Colors.black),
                  )),
            ],
          ));
  }
}
Color getButtonGradientColor(int num){
  switch(num){
    case 0:
      return const Color.fromARGB(255, 255, 191, 9);
    case 1:
      return const Color.fromARGB(255, 255, 157, 41);
    case 2:
      return const Color.fromARGB(255, 255, 125, 71);
    case 3:
      return const Color.fromARGB(255, 255, 93, 102);
    case 4:
      return Colors.pinkAccent;
    default:
      return Colors.white;
  }
}

class Pages extends StatelessWidget {
  late PageController controller;

  Pages(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageView = PageView(
      physics: NeverScrollableScrollPhysics(),
      //scrollBehavior: AppScrollBehavior(),
      controller: controller,
      children: <Widget>[News(), WorldMap(), WatchPoot(), HowToPlay(), Auth()],
    );
    return Expanded(flex: 9, child: pageView);
  }
}

// на случай если понадобится скролить руками
// https://stackoverflow.com/questions/69424933/flutter-pageview-not-swipeable-on-web-desktop-mode
// scrollBehavior: AppScrollBehavior(),
// class AppScrollBehavior extends MaterialScrollBehavior {
//   @override
//   Set<PointerDeviceKind> get dragDevices => {
//     PointerDeviceKind.touch,
//     PointerDeviceKind.mouse,
//   };
// }
