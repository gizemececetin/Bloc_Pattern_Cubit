import 'package:blocpatten/bloc/bloc_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bloc',
      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      home: BlocView(),
    );
  }
}
