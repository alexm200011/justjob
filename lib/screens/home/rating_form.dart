import 'package:flutter/material.dart';
import 'package:justjob/screens/home/rating.dart';
import 'package:rating_dialog/rating_dialog.dart';



class RatingForm extends StatefulWidget {
  //const RatingForm({Key? key}) : super(key: key);

  String? nombre;

  RatingForm(String? nombre){
    this.nombre = nombre;
  }

  @override
  _RatingFormState createState() => _RatingFormState(nombre: nombre);
}

class _RatingFormState extends State<RatingForm> {
  final String? nombre;
  _RatingFormState({this.nombre});

  @override
  Widget build (BuildContext context) {
    double calificacion;
    return Form(

        child:ListView(
          children: [
           RatingDialog(
            title: "Califica al trabajador",
            message: "Toca para calificar",
            image: Icon(Icons.star, size: 100, color: Colors.red,),
            submitButton: "Enviar Calificacion",
            onSubmitted: (response) {
              print("Calificación:${response.rating}");
              print("Opinion: ${response.comment}");
              calificacion = double.parse(response.rating.toString());
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rating(nombre,calificacion)),
              );
            }
          ),
          ],
        ),
    );
  }
}
