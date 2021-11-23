import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Welcome(),
  ));
}

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello"),
        centerTitle: false,
      ),
    );
  }
}
