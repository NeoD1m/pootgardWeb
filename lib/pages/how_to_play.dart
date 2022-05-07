import 'dart:convert';
import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class HowToPlay extends StatefulWidget {
  @override
  State<HowToPlay> createState() => HowToPlayState();
}

class HowToPlayState extends State<HowToPlay> {
  final List<bool> _isPanelOpen = List.filled(13, false);

  @override
  Widget build(BuildContext context) {
    double answersWidth = MediaQuery.of(context).size.width*0.75;
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
                child: coolDownloadButton(downloadFile)
              ),
              Container(
                width: answersWidth,
                margin: const EdgeInsets.only(bottom: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  //elevation: 0,
                  //expandedHeaderPadding: EdgeInsets.only(top: 100),
                  //dividerColor: CoolColors.mainColor,
                  children: [
                    textPanel(0,"Какой аккаунт использовать?","Для игры используется аккаунт с сайта pootgard.fun, создать который можно в личном кабинете. Этот же аккаунт используется для авторизации в лаунчере.",),
                    textPanel(0,"Системные требования","Минимальные системные требования: ОЗУ - 8гб, GPU - GTX 960, CPU - i5 6600\nРекомендованные системные требования: ОЗУ - 16гб, GPU - RTX 2070, CPU - Ryzen 7 3700x",),
                    textPanel(1,"Лаунчер","Играть на сервере можно только через лаунчер Euphoria пройдя авторизацию, оффициальный и tlauncher работать не будут."),
                    textPanel(2,"Режим боя","В игре существует два режима: боевой и строительный, для переключения по умолчанию используется кнопка R."),
                    textPanel(3,"Проблемы с подключением","Если у вас наблюдаются проблемы с подключением используйте VPN, например бесплатный OpenVPN. Для минимальной задержки лучше использовать VPN базированный в РФ."),
                    textPanel(4, "Сложность", "Сложность повышается при отдалении от спауна, у мобов повышается хп и урон."),
                    textPanel(5, "Прокачка", "За полученный опыт с убийства мобов вы получаете очки прокачки, потратить их можно нажав на E и кликнув на свиток."),
                    textPanel(6, "Голосовой чат", "По умолчанию голосовой чат настроен на push-to-talk и активируется на кнопку Caps Lock, изменить настройки можно в игре в меню Voice Settings."),
                    textPanel(7, "Сколько нужно оперативной памяти?", "Рекомендуется выделить 6-8 гигабайт оперативной памяти, чем больше - тем лучше."),
                    textPanel(8, "Настройки игры", "Чтобы настроить количество оперативной памяти или расположение файлов игры, зайдите на страницу сервера в лаунчере где находится кнопка \"играть\" и нажмите на кнопку настроект."),
                    textPanel(9, "Java", "Для корректной работы лаунчера и игры требуется Java 8."),
                    textPanel(9, "OpenGl error", "Чтобы отключить сообщение об ошибках OpenGL в игре откройте настройки и перейдите в Video Setting -> Other -> show OpenGl error."),
                    textPanel(10, "Шейдеры", "Вместе с игрой идет пак предустановленных шейдеров доступных на видеокартах Nvidia и AMD, чтобы активировать их в игре зайите Video Setting -> Shaders.\nЕсли после включения появились визуальные баги, в настройках шейдеров включите параметр Old Lighting."),
                    textPanel(11, "Переустановка игры", "Чтобы переустановить игру откройте настройки в лаунчере, перейдите в директорию с файлами и удалите её. Лаунчер при входе автоматически скачает нужные файлы."),
                    textPanel(12, "Как посмотреть крафт", "Чтобы узанть из чего крафтится предмет или что можно из него скрафтить, нажмите R и U соответсвенно, при наведении на предмет в инвентаре."),
                    textPanel(1, "Личные сообщения", "Чтобы отправить личное сообщение используйте команду /msg <Ник> <Текст сообщения>."),
                    textPanel(1, "Скин", "Установить скин можно в личном кабинете, поддерживаются как обычные, так и слим версии. Дополнительные слои отображаются, но отключить их в игре нельзя."),
                  ],
                  // expansionCallback: (i, isOpen) => setState(() {
                  //   _isPanelOpen[i] = !_isPanelOpen[i];
                  // }
                  ),
                ),

            ],
          ),
        ),
      ),
    );
  }
  Widget textPanel(int num,String theme,String mainText){
    return Container(
      //color: Colors.blue,
      margin: EdgeInsets.only(bottom: 50),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(theme,style: GoogleFonts.jost(
              fontWeight: FontWeight.bold,
              fontSize: 45.0,
              color: Colors.white)),
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(mainText,style: GoogleFonts.jost(
                //fontWeight: FontWeight.bold,
                fontSize: 40.0,
                color: Colors.white)),
          )
        ],
      ),
    );
  }

  ExpansionPanel CoolExpansionPanel(int num,String theme,String mainText){
    return ExpansionPanel(
        backgroundColor: Colors.pink,
        canTapOnHeader: true,
        headerBuilder: (context, isOpen) {
          return Container(
            margin: const EdgeInsets.only(left: 20),
              child: Text(theme,style: GoogleFonts.jost(
                fontWeight: FontWeight.bold,
                  fontSize: 45.0,
                  color: Colors.white) ,));
        },
        body: FlatButton(
          onPressed: () { _isPanelOpen[num] = false; setState(() {}); },
          child: Text(mainText,
              style: GoogleFonts.jost(
                  fontSize: 40.0,
                  color: Colors.white) //(fontSize: 40.0,color: CoolColors.textColor),
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
Widget coolDownloadButton(Function downloadFile){
  return
    RaisedButton(
      onPressed: () => {
        downloadFile(
            "https://launcher.pootgard.fun/Euphoria%20Launcher.exe")
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            stops: [
              0.1,
              0.9,
            ],
            colors: [Colors.amber, Colors.pinkAccent],
          ),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.download_sharp),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                    "Скачать Лаунчер",
                    style: GoogleFonts.jost(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black)
                ),
              ),
            ],
          ),
        ),
      ),
    );
}