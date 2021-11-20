import 'package:flutter/material.dart';
import 'package:flutter_crud/lunchmenu.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LunchMenu(),
    );
  }
}
