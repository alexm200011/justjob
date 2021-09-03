import 'package:flutter/material.dart';
import 'package:justjob/screens/authenticate/authenticate.dart';
import 'package:justjob/services/auth.dart';
import 'package:justjob/shared/constants.dart';
import 'package:justjob/shared/loading.dart';

class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);

  final Function toogleView;
  SignIn({required this.toogleView});


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool loading = false;


  //text field state
  String email = '';
  String password = '';
  String error='';

  @override
  Widget build(BuildContext context) {
      return loading ? Loading() : Scaffold(
        backgroundColor: Colors.lightBlue[100],
        appBar: AppBar(
          backgroundColor: Colors.lightBlue[400],
          elevation: 0.0,
          title: Text('Ingresa a JustJob'),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Registrate'),
              onPressed: () {
                widget.toogleView();
              },
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Expanded(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                      height: 140,
                    )),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val!.isEmpty ? 'Ingrese un correo' : null,
                    onChanged: (val){
                      setState(() => email = val);
                  }
                ),

                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Contraseña'),
                  validator: (val) => val!.length < 6 ? 'Ingrese una contraseña de 6 o mas caracteres' : null,
                  obscureText: true,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formkey.currentState!.validate()){
                      setState(() => loading = true);
                      dynamic result = await _auth.singInWithEmailAndPassword(email, password);
                      if(result == null){
                      setState(() {
                          error = 'No se pudo ingresar con esas credenciales';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      );
  }
}
