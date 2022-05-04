import 'package:flutter/material.dart';

Future showCoolDialog(BuildContext context,String title,String content){
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.amber),
        contentTextStyle: const TextStyle(color: Colors.amber),
        title: Text(title),
        content: Text(content),
      ));
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