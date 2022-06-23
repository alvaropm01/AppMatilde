import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sortea2/Providers/app_provider.dart';
import 'package:confetti/confetti.dart';
import "dart:math";

class WinnerScreen extends StatefulWidget {
  @override
  State<WinnerScreen> createState() => _WinnerScreenState();
}

class _WinnerScreenState extends State<WinnerScreen>
    with TickerProviderStateMixin {
  late ConfettiController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 1));
    _controller.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    final animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();
    final p = Provider.of<AppProvider>(context);
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Scaffold(
            body: Container(
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Color.fromARGB(255, 100, 181, 241),
                Color.fromARGB(255, 144, 202, 249),
                Color.fromARGB(255, 187, 222, 251)
              ],
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter)),
          child: SafeArea(
            child: Column(children: [
              Expanded(child: Container()),
              Text('Resultado: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo)),
              SizedBox(
                height: 20,
              ),
              Text(p.winner,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[900]
                      //Color.fromRGBO(239, 184, 16, 1)
                      )),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () {
                  p.resetParticipants();
                  Navigator.pushReplacementNamed(context, 'home');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                color: Colors.indigo,
                disabledColor: Colors.indigo.withOpacity(0.8),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text('Volver',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              ),
              Expanded(child: Container())
            ]),
          ),
        )),
        ConfettiWidget(
          confettiController: _controller,
          blastDirectionality: BlastDirectionality.explosive,
          numberOfParticles: 50,
          gravity: 0.5,
          emissionFrequency: 0.02,
          minBlastForce: 19,
          maxBlastForce: 20,
          colors: [
            Colors.yellow,
            Colors.orange,
            Colors.pink,
            Colors.purple,
            Colors.green,
            Colors.indigo
          ],
        ),
      ],
    );
  }
}
