import 'package:flutter/material.dart';
import 'package:justjob/screens/home/rating_form.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rating extends StatefulWidget {
  //const Rating({Key? key}) : super(key: key);

  String? nombre;
  double calificacion = 0.0;

  Rating(String? nombre, double calificacion){
    this.nombre = nombre;
    this.calificacion = calificacion;
  }

  @override
  _RatingState createState() => _RatingState(nombre: nombre, calificacion: calificacion.toString());

}


class _RatingState extends State<Rating> {

  final String? nombre;
  String? calificacion;
  String? justificacion;
  double rating = 0;
  _RatingState({this.nombre, this.calificacion});

  @override
  Widget build(BuildContext context) {

   // double valorcal = double.parse(calificacion!);
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text('Califica al trabajador'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/hombre.jpg'),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Estas calificado a: ${nombre}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Calificacion actual: ${calificacion}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            /*SmoothStarRating(
              rating: valorcal,
              size: 45,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              spacing: 2.0,
            ),*/
            Text(
              "$calificacion Estrellas",
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
                onPressed: (){
                  _showRatingPanel(this.nombre);
                  super.deactivate();
                  print('${this.nombre.toString()}');
                },
                child: Text('Calificar a ${nombre}'))
          ],
        ),
      ),
    );
  }

  void _showRatingPanel(String? nombre){
    showModalBottomSheet(context: context, builder: (context){
      return Container(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: RatingForm(nombre),
      );
    },  isScrollControlled: true);
  }

  /*void show(){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context){
          return RatingDialog(
              title: "Califica al trabajador",
              message: "Toca para calificar",
              image: Icon(Icons.star, size: 100, color: Colors.red,),
              submitButton: "Enviar Calificacion",
              onSubmitted: (response){
                this.rating = response.rating.toDouble();
                print("Calificación:${response.rating}");
                print("Opinion: ${response.comment}");
                calificacion = response.rating.toString();
                Navigator.pop(context);
              }
          );
        });
      }*/
}

