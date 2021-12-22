import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget{
  @override
  _NavigationPage createState() => _NavigationPage();
}
class _NavigationPage extends State<NavigationPage>{
  int counter =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Page'),
      ),
    );
  }
}