
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:justjob/models/justjob.dart';
import 'package:justjob/models/user.dart';
import 'package:justjob/screens/Swip/findWorkers.dart';
import 'package:justjob/screens/Swip/findJobs.dart';
import 'package:justjob/screens/home/settings_form.dart';
import 'package:justjob/services/auth.dart';
import 'package:justjob/services/database.dart';
import 'package:provider/provider.dart';
import 'justjob_list.dart';
import 'package:justjob/screens/home/justjob_list.dart';


class Home extends StatelessWidget  {
  //const Home({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<MUser?>(context);
    //final userData = Provider.of<MUserData?>(context);
    String deseo;
    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      },  isScrollControlled: true);
    }

    /*return  StreamProvider<List<JustJob>?>.value(
      value: DatabaseService().justJobs,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(
                          text: "Salir",
                          icon: Icon(Icons.exit_to_app),
                        )
                      ],
                    )
                )
              ],
            ),
          ),
          /*title: Text('Usuarios JustJob'),
          backgroundColor: Colors.lightBlue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Salir'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('configuraciones'),
              onPressed: () => _showSettingsPanel(),
            ),
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Trabajadores'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FindWorkers()),
                );
              }
            ),
            FlatButton.icon(
                icon: Icon(Icons.person),
                label: Text('Trabajadores'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FindWorkers()),
                  );
                }
            ),
          ]*/
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/job.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: JustJobList()),
      ),
    );*/


    return  StreamProvider<List<JustJob>?>.value(
      value: DatabaseService().justJobs,
      initialData: null,
      child: DefaultTabController(
        length: 4,
        child: Builder(builder: (BuildContext context){
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() async {
            if(!tabController.indexIsChanging){
              switch(tabController.index){
                case 0: {
                  await _auth.signOut();
                  tabController.index = 1;
                  break;
                }
                case 2: {
                  _showSettingsPanel();
                  tabController.index = 1;
                  break;
                }
                case 3: {
                  deseo = await DatabaseService(uid: user!.uid).getUserData();
                  print('el deseo ${deseo}');
                  if(deseo == 'trabajador'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FinJobds()),
                    );
                  }
                  else if(deseo == 'empleador'){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FindWorkers()),
                    );
                  }
                  tabController.index = 1;
                  break;
                }
              }
            }
          });
          return Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                  tabs:[
                    Tab(
                      text: "Salir",
                      icon: Icon(Icons.exit_to_app),

                    ),
                    Tab(
                      text: "Trabajadores",
                      icon: Icon(Icons.group_outlined),
                    ),
                    Tab(
                      text: "Perfil",
                      icon: Icon(Icons.settings),
                    ),
                    Tab(
                      text: "Contratar",
                      icon: Icon(Icons.contact_page),
                    )
                  ]
              ),
            ),
            body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/job.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: JustJobList()),
            );
        },
        ),
      ),
    );

  }
}
