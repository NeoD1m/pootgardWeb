import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pootgard_web/colors.dart';
import 'package:pootgard_web/pages/auth/profile.dart';
import 'package:pootgard_web/user.dart';
import 'package:crypto/crypto.dart';
import 'package:pootgard_web/userCubit.dart';
import '../authState.dart';
import '../../globals.dart' as globals;
import 'package:image_picker_web/image_picker_web.dart';
import 'package:gradient_textfield/gradient_textfield.dart';
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
    //print(response.body);
    var data = json.decode(response.body);
    //print(data.toString());
    if (data == "Success") {
      print("\n\nSUCCESSFUL LOGIN, NICE :)");
      globals.user.setName(user.username);
      changeStateTo(authState.main);
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(),),);
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text("Ошибка"), content: Text("Неверное имя или пароль")));
      print("\n\nERROR: WRONG PASSWORD OR USERNAME YOU IDIOT");
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
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
              title: Text("Ошибка"),
              content: Text("Аккаунт с таким именем уже существует")));
      print("\n\nERROR MUDAK\nUSER ALREADY EXISTS: ${user.username}");
    } else {
      changeStateTo(authState.main);
      print("\n\nSUCCESS\nUSER ADDED: ${user.username}");
    }
  }

  void changeStateTo(authState change) {
    print("STATE CHANGED FROM $state TO $change");
    state = change;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
        return LostPassword(changeStateTo);
    }
  }
}

Future<void> uploadFile(BuildContext context, String username) async {
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
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Успех"),
              content: Text("Вы успешно сменили скин"),
            ));
  }
}

class Login extends StatelessWidget {
  final Function login;
  final Function changeState;

  //User user;

  Login({Key? key, required this.changeState, required this.login})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CoolColors.mainColor,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Логин", style: TextStyle(fontSize: 45, color: Colors.amber)),
        InputField(
          usernameController,
          "Username",
          const EdgeInsets.only(top: 30),
          obscure: false,
          characterLimit: 32,
        ),
        InputField(
          passwdController,
          "Password",
          const EdgeInsets.only(top: 30),
          obscure: true,
          characterLimit: 32,
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
              child: Text("Я забыл пароль",
                  style: TextStyle(color: CoolColors.textColor)),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          width: 300,
          child: ElevatedButton(
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
    );
  }
}

class Register extends StatelessWidget {
  final Function register;
  final Function changeState;

  //User user;
  Register({Key? key, required this.changeState, required this.register})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController repeatPasswdController = TextEditingController();

  /// BETA
  final TextEditingController secretCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Регистрация",
                style: TextStyle(fontSize: 45, color: CoolColors.textColor)),
            InputField(
              usernameController,
              "Username",
              const EdgeInsets.only(top: 30),
              obscure: false,
              characterLimit: 20,
            ),
            InputField(
              emailController,
              "Email",
              const EdgeInsets.only(top: 30),
              obscure: false,
              characterLimit: 50,
            ),
            InputField(
              passwdController,
              "Password",
              const EdgeInsets.only(top: 30),
              obscure: true,
              characterLimit: 32,
            ),
            InputField(
              repeatPasswdController,
              "Repeat Password",
              const EdgeInsets.only(top: 30, bottom: 5),
              obscure: true,
              characterLimit: 32,
            ),
            InputField(
              secretCodeController,
              "Secret Code",
              const EdgeInsets.only(top: 30, bottom: 5),
              obscure: true,
              characterLimit: 32,
            ),
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
                  child: Text(
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
                  style: TextButton.styleFrom(
                      primary: CoolColors.buttonTextColor,
                      backgroundColor: CoolColors.buttonColor // Text Color
                      ),
                  onPressed: () {
                    /// check code
                    /// if valid delete from db and let user in
                    /// else say code is incorrect
                    userReg(
                        context,
                        usernameController,
                        emailController,
                        passwdController,
                        repeatPasswdController,
                        secretCodeController,
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
    TextEditingController secretCodeController,
    Function register) async {
  if (!globals.isAuthOn) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Ошибка"),
              content: Text("Регистрация закрыта"),
            ));
    return "Error";
  }

  if (usernameController.text.isEmpty ||
      emailController.text.isEmpty ||
      passwdController.text.isEmpty ||
      repeatPasswdController.text.isEmpty ||
      secretCodeController.text.isEmpty) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Ошибка"),
              content: Text("Не все поля заполнены"),
            ));
    return "Error";
  }

  if (passwdController.text != repeatPasswdController.text) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Ошибка"),
              content: Text("Пароли не совпадают"),
            ));
    return "Error";
  }

  bool isCodeValid = await isSecretCodeValid(secretCodeController.text);

  if (!isCodeValid) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              title: Text("Ошибка"),
              content: Text("Неверный секретный код"),
            ));
    return "Error";
  }

  globals.user.setName(usernameController.text);
  globals.user.setPassword(passwdController.text);
  globals.user.setEmail(emailController.text);
  register(globals.user);

  return "Success";
}

class InputField extends StatelessWidget {
  final TextEditingController _controller;
  final String hint;
  final bool obscure;
  final EdgeInsets margins;
  final int characterLimit;

  const InputField(this._controller, this.hint, this.margins,
      {Key? key, required this.characterLimit, required this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      width: 500,
      height: 50,
      child: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: [
                      0.1,
                      0.9,
                    ],
                    colors: [Colors.amber, Colors.pinkAccent],
                  ))),
          TextField(
            cursorColor: Colors.pink,
            style: const TextStyle(color: Colors.black),
            maxLength: characterLimit,
            obscureText: obscure,
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusColor: Colors.red,
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.pink,width: 2)),
              filled: true,
              hintText: hint,
              counterText: "",
            ),
          ),
        ],
      ),
    );
  }
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
