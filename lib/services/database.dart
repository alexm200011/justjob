import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:justjob/models/justjob.dart';
import 'package:justjob/models/user.dart';

class DatabaseService{

  final String? uid;
  DatabaseService({ this.uid });
  String? deseo;
  MTrabajador? mTrabajador;
  // collection reference

  final CollectionReference justJobCollection = FirebaseFirestore.instance.collection('justJobs');

  Future updateUserData(String? nombre, String? fecha_nac, String? deseo,
                        String? cedula, String? direccion, String? telefono,
                        String? niv_educacion, String? titulo) async{

    return await justJobCollection.doc(uid).set({
       'nombre': nombre,
       'fecha_nac': fecha_nac,
       'deseo':deseo,
       'cedula':cedula,
       'direccion':direccion,
       'telefono':telefono,
       'niv_educacion':niv_educacion,
       'titulo':titulo
    });
  }

  Future getUserData() async {

    await justJobCollection.doc(uid).get().then((doc) => {
        deseo = doc['deseo'].toString()
    });
    return deseo;
  }

  Future getTrabajadorData() async {
    await justJobCollection.doc(uid).get().then((doc) => {
      mTrabajador!.nombre = doc['nombre'].toString(),
      mTrabajador!.cedula = doc['cedula'].toString(),
      mTrabajador!.direccion = doc['direccion'].toString(),
      mTrabajador!.telefono = doc['telefono'].toString(),
      mTrabajador!.niv_educacion = doc['niv_educacion'].toString(),
      mTrabajador!.titulo = doc['titulo'].toString(),
    });
    return mTrabajador;
  }


  //justjob list from snapshot
  List<JustJob>? _justJobListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
        return JustJob(
          nombre: doc['nombre'] ?? '',
          fecha_nac: doc['fecha_nac'] ?? '',
          deseo: doc['deseo'] ?? '',
          cedula: doc['cedula'] ?? '',
          direccion: doc['direccion'] ?? '',
          telefono: doc['telefono'] ?? '',
          niv_educacion: doc['niv_educacion'] ?? '',
          titulo: doc['titulo'] ?? '',
        );
    }).toList();
  }

  // userData from Snapshot
  MUserData? _userDataFromSnapshot(DocumentSnapshot snapshot){
      return MUserData(
          uid: uid!,
          nombre : snapshot['nombre'],
          fecha_nac : snapshot['fecha_nac'],
          deseo : snapshot['deseo'],
          cedula : snapshot['cedula'],
          direccion : snapshot['direccion'],
          telefono : snapshot['telefono'],
          niv_educacion : snapshot['niv_educacion'],
          titulo : snapshot['titulo']
      );
  }

  MTrabajador? _trabajadorFromSnapshot(DocumentSnapshot snapshot){
    return MTrabajador(
        uid: uid!,
        nombre: snapshot['nombre'],
        cedula: snapshot['cedula'],
        direccion: snapshot['direccion'],
        telefono: snapshot['telefono'],
        niv_educacion: snapshot['niv_educacion'],
        titulo: snapshot['titulo']
    );
  }


  MEmpleos? _empleosFromSnapshot(DocumentSnapshot snapshot){
    return MEmpleos(
        uid: uid!,
        nombre: snapshot['nombre'],
        descripcion: snapshot['descripcion'],
        imagen: snapshot['imagen']
    );
  }

  MCalificaciones? _calificacionesFromSnapShot(DocumentSnapshot snapshot){
    return MCalificaciones(
        uid: uid!,
        calificacion: snapshot['calificacion'],
        comentario: snapshot['comentario']
    );
  }


  //get justjobs streams
   Stream<List<JustJob>?> get justJobs {
      return justJobCollection.snapshots()
          .map(_justJobListFromSnapshot);

  }

  //get user doc stream
  Stream<MUserData?> get userData {
    return justJobCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<MTrabajador?> get trabajador{
    return justJobCollection.doc(uid).snapshots().map(_trabajadorFromSnapshot);
  }

  Stream<MEmpleos?> get empleos{
    return justJobCollection.doc(uid).snapshots().map(_empleosFromSnapshot);
  }

  Stream<MCalificaciones?> get calificaciones{
    return justJobCollection.doc(uid).snapshots().map(_calificacionesFromSnapShot);
  }
}