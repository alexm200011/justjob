import 'package:flutter/material.dart';
import 'package:justjob/screens/authenticate/register.dart';
import 'package:justjob/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  //const ({Key? key}) : super(key: key);
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toogleView() {
    setState(()=> showSignIn = !showSignIn) ;
  }


  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toogleView:toogleView);
    }else{
      return Register(toogleView:toogleView);
    }

  }
}
