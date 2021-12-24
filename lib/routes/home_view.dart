import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }
}