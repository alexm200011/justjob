class MUser {

  final String uid;
  MUser ({ required this.uid });

}

class MUserData{

  final String uid;
  final String? nombre;
  final String? fecha_nac;
  final String? deseo;
  final String? cedula;
  final String? direccion;
  final String? telefono;
  final String? niv_educacion;
  final String? titulo;

  MUserData({required this.uid, this.nombre, this.fecha_nac, this.deseo, this.cedula, this.direccion, this.telefono, this.niv_educacion, this.titulo});

}

class MTrabajador {

  final String uid;
  final String? nombre;
  final String? cedula;
  final String? direccion;
  final String? telefono;
  final String? niv_educacion;
  final String? titulo;

  MTrabajador({required this.uid, this.nombre, this.cedula, this.direccion, this.telefono, this.niv_educacion, this.titulo});

}


class MEmpleos {

  final String uid;
  final String? nombre;
  final String? descripcion;
  final String? imagen;

  MEmpleos({required this.uid, this.nombre, this.descripcion, this.imagen});

}