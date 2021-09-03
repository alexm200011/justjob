import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justjob/models/justjob.dart';
import 'package:justjob/models/user.dart';



class TrabajadorService{

  final String? uid;
  TrabajadorService({ this.uid });

  final CollectionReference trabajadorCollection = FirebaseFirestore.instance.collection('trabajador');

    MTrabajador? _trabajadorDataFromSnapshot(DocumentSnapshot snapshot){
    return MTrabajador(
        uid: uid!,
        nombre : snapshot['nombre'],
        cedula : snapshot['cedula'],
        direccion : snapshot['direccion'],
        telefono : snapshot['telefono'],
        niv_educacion : snapshot['niv_educacion'],
        titulo : snapshot['titulo']
    );
  }

  //get user doc stream
  Stream<MTrabajador?> get userData {
    return trabajadorCollection.doc(uid).snapshots().map(_trabajadorDataFromSnapshot);
  }


}