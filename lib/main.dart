import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:retailer_app/view/login_view.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
  //initializing Firebase
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginView(),
    );
  }
}
