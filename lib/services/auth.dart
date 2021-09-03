import 'package:firebase_auth/firebase_auth.dart';
import 'package:justjob/models/user.dart';
import 'package:justjob/services/database.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create usr obj based on FirebaseUser
  MUser? _userFromFirebaseUser(User? user){
    return user != null ? MUser(uid: user.uid) : null;
  }
  // auth change user stream
  Stream<MUser?> get user {
    return _auth.authStateChanges()
        //.map((User? user) => _userFromFirebaseUser(user)); --> este proceso está implicito
        .map(_userFromFirebaseUser);
  }



  // Sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      var user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // Sign in with email & password
  Future singInWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //Register email & password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user!.uid).updateUserData('Nuevo Usuario', 'Sin Fecha asignada', 'Sin deseo Asignado', ''
                                                           'Sin cédula asignada', 'Sin direccion asignada', 'Sin número de telefono asignado', 'Sin nivel de educación asignado'
                                                          , 'Sin título asignado');

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }

  }

}
