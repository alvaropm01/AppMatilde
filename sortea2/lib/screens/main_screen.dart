import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sortea2/Providers/app_provider.dart';
import 'package:animate_do/animate_do.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.indigo),
          backgroundColor: Colors.blue.withOpacity(0),
          elevation: 0,
          actions: [
            GestureDetector(
              onTap: () {
                final p = Provider.of<AppProvider>(context, listen: false);
                p.resetTurno();
              },
              child: Container(
                color: Colors.blue.withOpacity(0.001),
                width: 200,
              ),
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                  Color.fromARGB(255, 144, 202, 249),
                  Color.fromARGB(255, 187, 222, 251)
                ],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter)),
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  _ShowParticipants(),
                  SizedBox(
                    height: 30,
                  ),
                  _NewParticipants(),
                ]),
              ),
            )));
  }
}

class _ShowParticipants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    int i = 0;
    return p.participants.length == 0
        ? Container()
        : Column(
            children: [
              Text('Lista de partipantes',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo)),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: p.participants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: FadeInLeftBig(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.indigo.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.indigo),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${index + 1}. ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.indigo),
                                  ),
                                  Text(
                                    p.participants[index],
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Expanded(child: Container()),
                                  IconButton(
                                    icon: Icon(Icons.delete_outline),
                                    color: Colors.indigo,
                                    onPressed: () {
                                      p.removeParticipants(index);
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  )
                                ],
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ),
              p.participants.length > 2
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: FadeInLeftBig(
                        duration: const Duration(milliseconds: 500),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Número de ganadores ',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.indigo),
                            ),
                            Container(
                              height: 25,
                              width: 37,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  fillColor: Colors.white.withOpacity(0.3),
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.indigo),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                initialValue: '1',
                              ),
                            )
                          ],
                        ),
                      ))
                  : Container()
            ],
          );
  }
}

class _NewParticipants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = Provider.of<AppProvider>(context);
    return Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Text('Añade participantes',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.indigo)),
              SizedBox(
                height: 10,
              ),
              _AddParticipants(),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: p.participants.length == 0
                    ? null
                    : () {
                        final p =
                            Provider.of<AppProvider>(context, listen: false);
                        p.selectWinner();
                        Navigator.pushNamed(context, 'winner');
                      },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                elevation: 0,
                color: Colors.indigo,
                disabledColor: Colors.indigo,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text('Sortear',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ));
  }
}

class _AddParticipants extends StatelessWidget {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.70,
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.2),
                  prefixIcon: Icon(Icons.person_add, color: Colors.indigo),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.indigo),
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
              color: Colors.indigo,
              disabledColor: Colors.indigo,
              onPressed: () {
                final p = Provider.of<AppProvider>(context, listen: false);

                p.addParticipant(_controller.text);
                _controller.clear();
              },
              child: Container(
                  height: 60,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  )))
        ],
      ),
    );
  }
}
