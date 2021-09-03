import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

class FindWorkers extends StatefulWidget {
  //const FindWorkers({Key? key}) : super(key: key);





  @override
  _FindWorkersState createState() => _FindWorkersState();
}

class _FindWorkersState extends State<FindWorkers> {

  List<String> _imagenes = [
      "hombre.jpg",
      "mujer.jpg",
      "hombre2.jpg",
      "hombre3.jpg",
      "hombre4.jpg",
      "mujer2.jpg",
      "mujer3.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
          return Scaffold(
            backgroundColor: Colors.lightBlueAccent[50],
            appBar: AppBar(
              backgroundColor: Colors.lightBlue[400],
              centerTitle: true,
              title: Text('Encuentra trabajadores'),
            ),
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/job.jpg'),
                      fit: BoxFit.cover
                  ),
                ),
                height: screenHeight - 200,
                child: TinderSwapCard(
                  allowVerticalMovement: false,
                  totalNum: _imagenes.length,
                  stackNum: 3,
                  maxHeight: screenHeight*0.7,
                  maxWidth: screenWidth*0.9,
                  minWidth: screenWidth*0.8,
                  minHeight: screenHeight * 0.65,
                  cardBuilder: (context,index){
                    return Card(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            color: Colors.white,
                            child: Image.asset('assets/${_imagenes[index]}'),
                          ),
                          SizedBox(height: 10,),
                          RichText(
                             text: TextSpan(
                               text: 'Información del Trabajador\n\n',
                               style: DefaultTextStyle.of(context).style,
                               children: const <TextSpan>[
                                 TextSpan(text: 'Aqui va el Nombre', style: TextStyle())
                               ]
                             ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.close, size: 50,color: Colors.orange,),
                              Icon(Icons.favorite, size: 50,color: Colors.orange,)
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  swipeCompleteCallback: (CardSwipeOrientation orientation, int index){

                    if(orientation == CardSwipeOrientation.LEFT){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Trabajador Rechazado'),
                            duration: Duration(milliseconds: 400),
                          )
                      );
                    }else if (orientation == CardSwipeOrientation.RIGHT){
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Trabajador Aceptado'),
                            duration: Duration(milliseconds: 400),
                          )
                      );
                    }
                  },
                ),
              ),
            ),
          );
        }
      }

