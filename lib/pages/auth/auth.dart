import 'dart:convert';
import 'dart:typed_data';
import 'package:Pootgard/pages/CoolWidgets.dart';
import 'package:Pootgard/pages/auth/profile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:webviewx/webviewx.dart';
import '../../colors.dart';
import '../../user.dart';
import '../authState.dart';
import '../../globals.dart' as globals;
import 'lost_password.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => AuthState();
}

class AuthState extends State<Auth> {
  authState state = authState.login;

  Future login(User user) async {
    var apiUrl = "https://auth.pootgard.fun/login.php";
    String securePassword = md5.convert(utf8.encode(user.password)).toString();
    var response = await http.post(Uri.parse(apiUrl), body: {
      "username": user.username,
      "password": securePassword,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      globals.user.setName(user.username);
      changeStateTo(authState.main);
    } else {
      showCoolDialog(context, "Ошибка", "Неверное имя или пароль");
    }
  }

  register(User user) async {
    var apiUrl = "https://auth.pootgard.fun/register.php";
    String securePassword = md5.convert(utf8.encode(user.password)).toString();
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        "username": user.username,
        "password": securePassword,
        "email": user.email,
      },
    );
    var data = json.decode(response.body);
    if (data == "Error") {
      showCoolDialog(context, "Ошибка", "Аккаунт с таким именем уже существует");
    } else {
      changeStateTo(authState.main);
    }
  }

  void changeStateTo(authState change) {
    state = change;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if(globals.user.username != "") return Profile();

    switch (state) {
      case authState.register:
        return Register(register: register, changeState: changeStateTo);
      case authState.login:
        return Login(
          changeState: changeStateTo,
          login: login,
        );
      case authState.main:
        return Profile();
      case authState.lostPassword:
        return LostPassword(changeState: changeStateTo,);
    }
  }
}

Future<void> uploadSkin(BuildContext context, String username,WebViewXController webViewController) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['png'],
  );
  Uint8List? fileBytes = result?.files.first.bytes;
  String base64 = base64Encode(fileBytes!);
  var apiUrl = "https://skins.pootgard.fun/uploadSkin.php";
  var response = await http.post(
    Uri.parse(apiUrl),
    body: {
      "image": base64.toString(),
      "name": "$username.png",
    },
  );
  if (response.body == "Success") {
    showCoolDialog(context, "Успех", "Вы успешно сменили скин");
    webViewController.loadContent(
      'https://skins.pootgard.fun/skinviewer/Minecraft-SkinViewer-master/index.php?name=$username',
      SourceType.url,
    );
  }
}

class Login extends StatelessWidget {
  final Function login;
  final Function changeState;

  Login({Key? key, required this.changeState, required this.login})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final List<FocusNode> nodes = [FocusNode(canRequestFocus: true),FocusNode(canRequestFocus: true),FocusNode()];
  void focus(int num){
    if (nodes.length >= num+1){
      nodes[num+1].requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.mainColor,
      child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Логин", style: TextStyle(fontSize: 45, color: Colors.amber)),
            InputField(
              usernameController,
              "Username",
              const EdgeInsets.only(top: 30),
              obscure: false,
              characterLimit: 32,
              nodes: nodes,
              focus: focus,
              positionInNodes: 0,
            ),
            InputField(
              passwdController,
              "Password",
              const EdgeInsets.only(top: 30),
              obscure: true,
              characterLimit: 32,
              nodes: nodes,
              focus: focus,
              positionInNodes: 1,
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10, right: 25),
              //height: 20,
              width: 500,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    changeState(authState.register);
                  },
                  child: const Text("У меня нет аккаунта",
                      style: TextStyle(color: CoolColors.textColor)),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, right: 25),
              //height: 20,
              width: 500,
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    changeState(authState.lostPassword);
                  },
                  child: const Text("Я забыл пароль",
                      style: TextStyle(color: CoolColors.textColor)),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ElevatedButton(
                  focusNode: nodes[2],
                  style: TextButton.styleFrom(
                      primary: CoolColors.buttonTextColor,
                      backgroundColor: CoolColors.buttonColor // Text Color
                      ),
                  onPressed: () {
                    globals.user.setName(usernameController.text);
                    globals.user.setPassword(passwdController.text);
                    login(globals.user);
                  },
                  child: const Text(
                    "Войти",
                    style: TextStyle(fontSize: 20),
                  )),
            )
          ]),
        ),
      ),
    );
  }
}

class Register extends StatelessWidget {
  final Function register;
  final Function changeState;

  Register({Key? key, required this.changeState, required this.register})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController repeatPasswdController = TextEditingController();
  final List<FocusNode> nodes = [FocusNode(canRequestFocus: true),FocusNode(canRequestFocus: true),FocusNode(canRequestFocus: true),FocusNode(canRequestFocus: true),FocusNode()];

  /// BETA
  //final TextEditingController secretCodeController = TextEditingController();
  void focus(int num){
    if (nodes.length >= num+1){
      nodes[num+1].requestFocus();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Регистрация",
                  style: TextStyle(fontSize: 45, color: CoolColors.textColor)),
              InputField(
                usernameController,
                "Username",
                const EdgeInsets.only(top: 30),
                obscure: false,
                characterLimit: 20,
                nodes: nodes,
                focus: focus,
                positionInNodes: 0,
              ),
              InputField(
                emailController,
                "Email",
                const EdgeInsets.only(top: 30),
                obscure: false,
                characterLimit: 50,
                nodes: nodes,
                focus: focus,
                positionInNodes: 1,
              ),
              InputField(
                passwdController,
                "Password",
                const EdgeInsets.only(top: 30),
                obscure: true,
                characterLimit: 32,
                nodes: nodes,
                focus: focus,
                positionInNodes: 2,
              ),
              InputField(
                repeatPasswdController,
                "Repeat Password",
                const EdgeInsets.only(top: 30, bottom: 5),
                obscure: true,
                characterLimit: 32,
                nodes: nodes,
                focus: focus,
                positionInNodes: 3,
              ),
              // InputField(
              //   secretCodeController,
              //   "Secret Code",
              //   const EdgeInsets.only(top: 30, bottom: 5),
              //   obscure: true,
              //   characterLimit: 32,
              //   nodes: nodes,
              //   focus: focus,
              //   positionInNodes: 4,
              // ),
              Container(
                margin: const EdgeInsets.only(bottom: 30, right: 25),
                height: 50,
                width: 500,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      changeState(authState.login);
                    },
                    child: const Text(
                      "У меня уже есть аккаунт",
                      style: TextStyle(color: CoolColors.textColor),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                    focusNode: nodes[4],
                    style: TextButton.styleFrom(
                        primary: CoolColors.buttonTextColor,
                        backgroundColor: CoolColors.buttonColor // Text Color
                        ),
                    onPressed: () {
                      userReg(
                          context,
                          usernameController,
                          emailController,
                          passwdController,
                          repeatPasswdController,
                          register);
                    },
                    child: const Text(
                      "Войти",
                      style: TextStyle(fontSize: 20),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> isSecretCodeValid(String superSecretCode) async {
  var apiUrl = "https://auth.pootgard.fun/checkCode.php";
  var response = await http.post(
    Uri.parse(apiUrl),
    body: {
      "code": superSecretCode,
    },
  );
  var data = json.decode(response.body);

  if (data == "Success") {
    return true;
  }
  return false;
}

Future<String> userReg(
    BuildContext context,
    TextEditingController usernameController,
    TextEditingController emailController,
    TextEditingController passwdController,
    TextEditingController repeatPasswdController,
    Function register) async {
  if (!globals.isAuthOn) {
    showCoolDialog(context, "Ошибка", "Регистрация закрыта");
    return "Error";
  }

  if (usernameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwdController.text.isEmpty ||
      repeatPasswdController.text.isEmpty) {
    showCoolDialog(context, "Ошибка", "Не все поля заполнены");
    return "Error";
  }

  if (passwdController.text != repeatPasswdController.text) {
    showCoolDialog(context, "Ошибка", "Пароли не совпадают");
    return "Error";
  }

  if(usernameController.text.contains(" ")){
    showCoolDialog(context, "Ошибка", "Использовать пробелы в имени запрещено");
    return "Error";
  }

  // bool isCodeValid = await isSecretCodeValid(secretCodeController.text);
  //
  // if (!isCodeValid) {
  //   showCoolDialog(context, "Ошибка", "Неверный секретный код");
  //   return "Error";
  // }

  globals.user.setName(usernameController.text);
  globals.user.setPassword(passwdController.text);
  globals.user.setEmail(emailController.text);
  register(globals.user);

  return "Success";
}



// headers: {
// //"Access-Control-Allow-Origin": "*", // Required for CORS support to work
// // "Accept": "application/json",
// // // "Access-Control-Allow-Credentials": "true", // Required for cookies, authorization headers with HTTPS
// // "Access-Control-Allow-Headers": "Content-Type", //Origin,,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale
// // "Access-Control-Allow-Methods": "GET,HEAD,POST, OPTIONS"
// }

// LinearGradient(
// begin: Alignment.topRight,
// end: Alignment.bottomLeft,
// colors: [
// Colors.blue,
// Colors.red,
// ],
// )
