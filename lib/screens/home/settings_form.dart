
import 'package:flutter/material.dart';
import 'package:justjob/models/user.dart';
import 'package:justjob/services/database.dart';
import 'package:justjob/shared/constants.dart';
import 'package:justjob/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  //const SettingsForm({Key? key}) : super(key: key);
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

enum justJobPreference { trabajador, empleador }

class _SettingsFormState extends State<SettingsForm> {

  justJobPreference? _character = justJobPreference.trabajador;


  final _formKey = GlobalKey< FormState>();
  final List<String> titulos = ['Ing. Software','Arquitecto','Médico','Ing.Civil'];
  final List<String> nivelEducacion = ['Primaria','Educación General Básica','Bachillerato','Educación Superior(Pregrado)'
                                      ,'Educación Superior (3er Nivel)','Posgrado (4to y 5to Nivel)'];

  //Form Values
  late String? _actualNombre = null;
  late String? _actualTitulo = null;
  late String? _actualNivelEducacion = null;
  late String? _actualCedula = null;
  late String? _actualDeseo = null;
  late String? _actualDireccion = null;
  late String? _actualFechaNac = null;
  late String? _actualTelefono = null;

  var _currentSelectedDate = DateTime.now();



  void callDatePicker() async {
    var selectedDate = await getDatePickerWidget();
    setState(() {
      _currentSelectedDate = selectedDate!;
    });
    _actualFechaNac = _currentSelectedDate.toString();
  }

  Future <DateTime?> getDatePickerWidget(){
      return showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
      );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MUser?>(context);
    return StreamBuilder<MUserData?>(
        stream: DatabaseService(uid: user!.uid).userData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            MUserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Actualiza los datos de tu perfil',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData!.nombre,
                    decoration: textInputDecoration.copyWith(hintText: 'Nombre'),
                    validator: (val) => val!.isEmpty ? 'Porfavor ingrese su nombre' : null,
                    onChanged: (val) => setState(() => _actualNombre = val),
                  ),
                  TextFormField(
                    initialValue: userData!.direccion,
                    decoration: textInputDecoration.copyWith(hintText: 'Dirección'),
                    validator: (val) => val!.isEmpty ? 'Porfavor ingrese su dirección' : null,
                    onChanged: (val) => setState(() => _actualDireccion = val),
                  ),
                  TextFormField(
                    initialValue: userData!.telefono,
                    decoration: textInputDecoration.copyWith(hintText: 'Teléfono'),
                    validator: (val) => val!.isEmpty ? 'Porfavor ingrese su teléfono' : null,
                    onChanged: (val) => setState(() => _actualTelefono = val),
                  ),
                  TextFormField(
                    initialValue: userData!.cedula,
                    decoration: textInputDecoration.copyWith(hintText: 'Cédula'),
                    validator: (val) => val!.isEmpty ? 'Porfavor ingrese su cédula' : null,
                    onChanged: (val) => setState(() => _actualCedula = val),
                  ),
                  ListTile(
                    title: const Text('Trabajador'),
                    leading: Radio<justJobPreference>(
                      value: justJobPreference.trabajador,
                      groupValue: _character,
                      onChanged: (justJobPreference? value) {
                        setState(() {
                          _character = value;
                          _actualDeseo = 'trabajador';
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Empleador'),
                    leading: Radio<justJobPreference>(
                      value: justJobPreference.empleador,
                      groupValue: _character,
                      onChanged: (justJobPreference? value) {
                        setState(() {
                          _character = value;
                          _actualDeseo = 'empleador';
                        });
                      },
                    ),
                  ),
                  /*TextFormField(
                    initialValue: userData!.fecha_nac,
                    decoration: textInputDecoration.copyWith(hintText: 'Fecha de nacimiento'),
                    validator: (val) => val!.isEmpty ? 'Porfavor ingrese su fecha de nacimiento' : null,
                    onTap: (){
                       callDatePicker();
                    },
                    onChanged: (val) => setState(() => _actualFechaNac = val),
                  ),*/
                  MaterialButton(
                    minWidth: 300.0,
                    height: 40.0,
                    onPressed: () {
                      callDatePicker();
                    },
                    color: Colors.lightBlue,
                    child: Text('${_currentSelectedDate}', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  //DROPDOWN
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Título'),
                    //value: _actualTitulo ?? 'Ing Software',
                    items: titulos.map((titulo){
                      return DropdownMenuItem(
                        value: titulo,
                        child: Text('$titulo'),
                      );
                    }).toList(),
                    onChanged: (val){
                      setState(()=> _actualTitulo = val as String?);
                    },
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Nivel de educación'),
                    //value: _actualTitulo ?? 'Ing Software',
                    items: nivelEducacion.map((nivelEducativo){
                      return DropdownMenuItem(
                        value: nivelEducativo,
                        child: Text('$nivelEducativo'),
                      );
                    }).toList(),
                    onChanged: (val){
                      setState(()=> _actualNivelEducacion = val as String?);
                    },
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Actualizar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      /*print(_actualNombre);
                      print(_actualNivelEducacion);
                      print(_actualTitulo);
                      print(_actualDeseo);
                      print(_actualDireccion);
                      print(_actualTelefono);
                      print(_actualFechaNac);
                      print(_actualCedula);*/

                      if(_formKey.currentState!.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          _actualNombre ?? userData.nombre,
                          _actualFechaNac ?? userData.fecha_nac,
                          _actualDeseo ?? userData.deseo,
                          _actualCedula ?? userData.cedula,
                          _actualDireccion ?? userData.direccion,
                          _actualTelefono ?? userData.telefono,
                          _actualNivelEducacion ?? userData.niv_educacion,
                          _actualTitulo ?? userData.titulo,
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            );
          }else{
            return Loading();
          }
      }
    );
  }

}

