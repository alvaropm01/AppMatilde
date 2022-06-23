import 'package:flutter/material.dart';
import 'package:sortea2/Providers/app_provider.dart';
import 'package:sortea2/screens/home_screen.dart';
import 'package:sortea2/screens/main_screen.dart';
import 'package:sortea2/screens/winner_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  return runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AppProvider()),
  ], child: (MyApp())));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sortea2',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScreen(),
        'main': (_) => MainScreen(),
        'winner': (_) => WinnerScreen()
      },
    );
  }
}
