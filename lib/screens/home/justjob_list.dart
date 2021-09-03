import 'package:flutter/material.dart';
import 'package:justjob/models/justjob.dart';
import 'package:provider/provider.dart';
import 'justjob_tile.dart';
import 'package:justjob/screens/home/justjob_tile.dart';



class JustJobList extends StatefulWidget {
  //const JustJobList({Key? key}) : super(key: key);

  @override
  _JustJobListState createState() => _JustJobListState();
}

class _JustJobListState extends State<JustJobList> {
  @override
  Widget build(BuildContext context) {

    final justJobs = Provider.of<List<JustJob>?>(context) ?? [];

    /*if (justJobs != null)
    justJobs.forEach((justJob){
        print(justJob.nombre);
        print(justJob.fecha_nac);
        print(justJob.deseo);
        print(justJob.cedula);
        print(justJob.direccion);
        print(justJob.telefono);
        print(justJob.niv_educacion);
        print(justJob.titulo);
    });*/

    return ListView.builder(
      itemCount: justJobs!.length,
      itemBuilder: (context, index){
        return JustJobTile(justJob: justJobs[index]);
      },
    );
  }
}
