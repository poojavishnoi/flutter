import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_todo_app/pages/Home.dart';
import 'package:flutter_todo_app/pages/SignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBm_yl2ZTJkgx6znsaATyPijljZ6vFMaCI",
          authDomain: "flutter-todo-717d8.firebaseapp.com",
          projectId: "flutter-todo-717d8",
          storageBucket: "flutter-todo-717d8.appspot.com",
          messagingSenderId: "744071024277",
          appId: "1:744071024277:web:c7378d93b58cb4ba5a559c",
          measurementId: "G-L7KGPRNFWL"));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

  void signup() async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: "poojavishnoi@gmail.com", password: "pooja123");
    } catch (e) {
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SignUpPage());
  }
}
