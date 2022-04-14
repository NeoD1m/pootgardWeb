import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pootgard_web/user.dart';
import 'package:crypto/crypto.dart';
import 'package:pootgard_web/userCubit.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => AuthState();
}

enum authState { register, login, main }

class AuthState extends State<Auth> {
  authState state = authState.register;
  User user = User(
    "",
    "",
    "",
  );

  Future login(User user) async {
    var apiUrl = "https://auth.pootgard.fun/login.php";
    String securePassword = md5.convert(utf8.encode(user.password)).toString();
    var response = await http.post(Uri.parse(apiUrl), body: {
      "username": user.username,
      "password": securePassword,
    });
    var data = json.decode(response.body);
    if (data == "Success") {
      print("\n\nSUCCESSFUL LOGIN, NICE :)");
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
    UserCubit userCubit = UserCubit();

    switch (state) {
      case authState.register:
        return Register(
            register: register, changeState: changeStateTo, user: user,userCubit: userCubit,);
      case authState.login:
        return Login(
          changeState: changeStateTo,
          login: login,
          user: user,
        );
      case authState.main:
        return Main(user: user,userCubit: userCubit,);
    }
  }
}

class Main extends StatelessWidget {
  final User user;
  UserCubit userCubit;
  Main({Key? key, required this.user,required this.userCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "YOUR NAME IS ${user.username} OR ${userCubit.getName()}",
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  final Function login;
  final Function changeState;
  User user;

  Login(
      {Key? key,
      required this.changeState,
      required this.login,
      required this.user})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Логин", style: TextStyle(fontSize: 45)),
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
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        //height: 20,
        width: 500,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              changeState(authState.register);
            },
            child: const Text("У меня нет аккаунта"),
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 30),
        //height: 20,
        width: 500,
        child: Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              print("CHANGE OF PASSWORD REQUESTED");
            },
            child: Text("Я забыл пароль"),
          ),
        ),
      ),
      SizedBox(
        height: 50,
        width: 300,
        child: ElevatedButton(
            onPressed: () {
              user =
                  User("null", usernameController.text, passwdController.text);
              login(user);
            },
            child: const Text(
              "Войти",
              style: TextStyle(fontSize: 20),
            )),
      )
    ]);
  }
}

class Register extends StatelessWidget {
  final Function register;
  final Function changeState;
  User user;
  UserCubit userCubit;
  Register(
      {Key? key,
      required this.user,
      required this.changeState,
      required this.register,
      required this.userCubit})
      : super(key: key);
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwdController = TextEditingController();
  final TextEditingController repeatPasswdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Регистрация", style: TextStyle(fontSize: 45)),
          InputField(
            usernameController,
            "Username",
            const EdgeInsets.only(top: 30),
            obscure: false,
            characterLimit: 32,
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
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            height: 50,
            width: 500,
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  changeState(authState.login);
                },
                child: Text("У меня уже есть аккаунт"),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 300,
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        title: Text("Ошибка"),
                        content: Text("Регистрация закрыта"),
                      ));
                  // if (passwdController.text == repeatPasswdController.text) {
                  //   user = User(emailController.text, usernameController.text,
                  //       passwdController.text);
                  //   register(user);
                  //   userCubit.setName("a");
                  // } else {
                  //   showDialog(
                  //       context: context,
                  //       builder: (context) => const AlertDialog(
                  //             title: Text("Ошибка"),
                  //             content: Text("Пароли не совпадают"),
                  //           ));
                  // }
                },
                child: const Text(
                  "Войти",
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.cyan,
      ),
    );
  }
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
      child: TextField(
        maxLength: characterLimit,
        obscureText: obscure,
        controller: _controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          counterText: "",
        ),
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
