import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget{
  @override
  _NotificationPage createState() => _NotificationPage();
}
class _NotificationPage extends State<NotificationPage>{
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
    );
  }
}