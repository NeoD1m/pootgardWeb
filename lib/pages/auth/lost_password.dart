import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';
import '../CoolWidgets.dart';
import '../authState.dart';
import 'auth.dart';
class LostPassword extends StatelessWidget{
  Function changeState;
  LostPassword({Key? key, required this.changeState})
      : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final List<FocusNode> nodes = [FocusNode(canRequestFocus: true),FocusNode()];
  void focus(int num){
    if (nodes.length >= num+1){
      nodes[num+1].requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.mainColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Восстановление аккаунта", style: TextStyle(fontSize: 45, color: Colors.amber)),
        InputField(
          emailController,
          "Email",
          const EdgeInsets.only(top: 30),
          obscure: false,
          onlyAllowEnd: false,
          characterLimit: 32,
          nodes: nodes,
          focus: focus,
          positionInNodes: 0,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 30, right: 25),
          //height: 20,
          width: 500,
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                changeState(authState.login);
              },
              child: const Text("Я вспомнил пароль",
                  style: TextStyle(color: CoolColors.textColor)),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
            focusNode: nodes[1],
              style: TextButton.styleFrom(
                  primary: CoolColors.buttonTextColor,
                  backgroundColor: Colors.grey // Text Color
              ),
              onPressed: () {
                // globals.user.setName(usernameController.text);
                // globals.user.setPassword(passwdController.text);
                // login(globals.user);
              },
              child: const Text(
                "Отправить",
                style: TextStyle(fontSize: 20),
              )),
        )
      ]),
    );
  }
}