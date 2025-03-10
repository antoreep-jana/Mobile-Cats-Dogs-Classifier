import 'package:flutter/material.dart';
import 'package:objectdetection/HomePage.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Image Classifier",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
          foregroundColor: Colors.black
        )
      ),
      home: const HomeScreen(),
    );
  }
}

