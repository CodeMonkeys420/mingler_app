import 'package:mingler_app/models/user.dart';
import 'package:mingler_app/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user == null){
      return Authenticate();
    }else
    {
      return MyHomePage();
    }
    //return home or authenticate widget
  }
}