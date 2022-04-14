import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pootgard_web/user.dart';

class UserCubit extends Cubit<User>{
  UserCubit() : super(User("email", "username", "password"));

  String name = "";

  String getName(){
    return name;
  }

  void setName(String name){
    this.name = name;
  }
}