import 'package:flutter/material.dart';
import 'package:justjob/models/user.dart';

import 'package:justjob/screens/Swip/findWorkers.dart';
import 'package:justjob/screens/authenticate/authenticate.dart';
import 'package:justjob/screens/home/home.dart';
import 'package:provider/provider.dart';

import 'home/notifications.dart';

class Wrapper extends StatelessWidget {
  //const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MUser?>(context);
    print(user);
    // return either Home or Authenticate widget
    //return Authenticate();
    if(user == null){
      return Authenticate();
    } else{
      return Home();
    }
  }
}
