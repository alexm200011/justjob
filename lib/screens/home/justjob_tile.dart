import 'package:flutter/material.dart';
import 'package:justjob/models/justjob.dart';
import 'package:justjob/screens/home/rating.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';



class JustJobTile extends StatelessWidget {
  //const JustJobTile({Key? key}) : super(key: key);





  final JustJob? justJob;
  JustJobTile({this.justJob});


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
          child: ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Rating(justJob!.nombre,3.0)),
              );
            },
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[100],
            ),
            title: Text(justJob!.nombre.toString()),
            subtitle: Text('Título: ${justJob!.titulo}'),
          ),
        ),
    );
  }

}
