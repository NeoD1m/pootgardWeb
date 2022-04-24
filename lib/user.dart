import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

class User{
  User({Key? key,required this.email,required this.username,required this.password});
  String username;
  String password;
  String email;

  void setName(String name){
    username = name;
  }
  void setEmail(String email){
    this.email = email;
  }
  void setPassword(String password){
    this.password = password;
  }

}