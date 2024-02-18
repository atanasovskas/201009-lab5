import 'package:flutter/material.dart';
import 'widget_tree.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBSBa4XIyjGbtRt7cwp9-7QB-9NTsKfoZw",
      appId: "1:607007144310:android:15722e100cb403d7cca257",
      messagingSenderId: "607007144310",
      projectId: "lab3-ecdea",
    ),
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key ? key}) :super( key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:  false,
      theme: ThemeData(
        primarySwatch:  Colors.lightBlue
      ),
      home: const WidgetTree(),
    );
  }
}

