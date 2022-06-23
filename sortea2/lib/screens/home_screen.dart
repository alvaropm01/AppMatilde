import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sortea2/Providers/app_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: new BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color.fromARGB(255, 100, 181, 241),
            Color.fromARGB(255, 144, 202, 249),
            Color.fromARGB(255, 187, 222, 251)
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter)),
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.width * 0.4,
        ),
        Container(
            height: 250, child: Image(image: AssetImage('assets/no.png'))),
        SizedBox(
          height: 30,
        ),
        MaterialButton(
          onPressed: () {
            final p = Provider.of<AppProvider>(context, listen: false);
            p.resetParticipants();
            Navigator.pushNamed(context, 'main');
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: Colors.indigo,
          disabledColor: Colors.indigo,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Text('Nuevo sorteo',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MaterialButton(
          onPressed: () async {
            await launchUrl(
                Uri.parse('https://www.sortea2.com/registro/registra_o_login'));
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
          color: Colors.indigo,
          disabledColor: Colors.indigo,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 35, vertical: 5),
              child: Text('Sorteo Certificado',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white)),
            ),
          ),
        ),
      ]),
    ));
  }
}
