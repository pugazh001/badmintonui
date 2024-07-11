import 'package:flutter/material.dart';
import 'input_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Badminton Event',
      debugShowCheckedModeBanner: false,
    
      home:InputPage(),
    );
  }
}