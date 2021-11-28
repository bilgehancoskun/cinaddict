import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  // TODO: Create a welcome view

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Stack (Welcome View)'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Go Back button on appBar should not be shown and the "back" button in device navigator should close the app.',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 60,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Go To Login View')),
            SizedBox(
              height: 20,
            ),
            Text(
              'This button should work and lands you into Login View.',
              textAlign: TextAlign.center,
            ),

          ],
        ),
      ),
    );
  }
}
