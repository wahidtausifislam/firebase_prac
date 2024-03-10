import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_prac/data_show_screen.dart';
import 'package:flutter/material.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Note App",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () {
                firestore
                    .collection("users")
                    .add({
                      "name": "Shohan",
                      "class": "graduate",
                      "id": "201-15-3401",
                    })
                    .then((value) => print("data added"))
                    .catchError((error) => print("Failed to add user: $error"));
                ;
              },
              child: const Text("Set Data")),
          ElevatedButton(
              onPressed: () {
                firestore
                    .collection("users")
                    .doc("01")
                    .set({
                      "name": "Jony",
                      "class": "graduate",
                      "id": "201-15-3401",
                    })
                    .then((value) => print("data added"))
                    .catchError((error) => print("Failed to add user: $error"));
                ;
              },
              child: Text("Add Data")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Datashowscreen()));
              },
              child: Text("Next Screen")),
        ],
      )),
    );
  }
}
