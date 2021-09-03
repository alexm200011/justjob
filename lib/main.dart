import 'package:flutter/material.dart';
import 'package:justjob/models/user.dart';
import 'package:justjob/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:justjob/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:justjob/models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MUser?>.value(
      value: AuthService().user,
      //--> por investigar
        initialData: null,
        child: MaterialApp(
          home: Wrapper(),
      ),
    );
  }
}

