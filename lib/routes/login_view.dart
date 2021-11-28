import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  // TODO: Create a login view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Stack (Login View)'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The back button in appBar or back button on device navigator '
              'should work and should navigate back to Welcome View.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
