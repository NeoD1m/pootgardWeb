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
                    CoolExpansionPanel(0,"Какой аккаунт использовать?","Для игры используется аккаунт с сайта pootgard.fun, создать который можно в личном кабинете. Этот же аккаунт используется для авторизации в лаунчере.",),
                    CoolExpansionPanel(1,"Лаунчер","Играть на сервере можно только через лаунчер Euphoria пройдя авторизацию, оффициальный и tlauncher работать не будут."),
                    CoolExpansionPanel(2,"Режим боя","В игре существует два режима: боевой и строительный, для переключения по умолчанию используется кнопка R."),
                    CoolExpansionPanel(3,"Проблемы с подключением","Если у вас наблюдаются проблемы с подключением используйте VPN, например бесплатный OpenVPN."),
                    CoolExpansionPanel(4, "Сложность", "Сложность повышается при отдалении от спауна, у мобов повышается хп и урон."),
                    CoolExpansionPanel(5, "Прокачка", "За полученный опыт с убийства мобов вы получаете очки прокачки, потратить их можно нажав на E и кликнув на свиток."),
                    CoolExpansionPanel(6, "Голосовой чат", "По умолчанию голосовой чат настроен на push-to-talk и активируется на кнопку Caps Lock, изменить настройки можно в игре в меню Voice Settings."),
                    CoolExpansionPanel(7, "Сколько нужно оперативной памяти", "Рекомендуется выделить 6-8 гигабайт оперативной памяти, чем больше - тем лучше."),
                    CoolExpansionPanel(8, "Настройки игры", "Чтобы настроить количество оперативной памяти или расположение файлов игры, зайдите на страницу сервера в лаунчере где находится кнопка \"играть\" и нажмите на кнопку настроект."),
                    CoolExpansionPanel(9, "OpenGl error", "Чтобы отключить сообщение об ошибках OpenGL в игре откройте настройки и перейдите в Video Setting -> Other -> show OpenGl error."),
                    CoolExpansionPanel(10, "Шейдеры", "Вместе с игрой идет пак предустановленных шейдеров доступных на видеокартах Nvidia и AMD, чтобы активировать их в игре зайите Video Setting -> Shaders."),
                    CoolExpansionPanel(11, "Переустановка игры", "Чтобы переустановить игру откройте настройки в лаунчере, перейдите в директорию с файлами и удалите её. Лаунчер при входе автоматически скачает нужные файлы."),
                    CoolExpansionPanel(12, "Как посмотреть крафт", "Чтобы узанть из чего крафтится предмает или что можно из него скрафтить, нажмите R и U соответсвенно, при наведении на предмет в инвентаре."),
                    //CoolExpansionPanel(4, "", ""),
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
  ExpansionPanel CoolExpansionPanel(int num,String theme,String mainText){
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
          onPressed: () { _isPanelOpen[num] = false; setState(() {}); },
          child: Text(mainText,
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
