import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatefulWidget{
  @override
  _MoviePage createState() => _MoviePage();
}
class _MoviePage extends State<MoviePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }
}