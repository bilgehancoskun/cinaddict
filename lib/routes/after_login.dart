import 'package:cinaddict/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AfterLoginDummy extends StatelessWidget {
  const AfterLoginDummy({Key? key, this.user}) : super(key: key);
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Successfully Logged In'),
        backgroundColor: AppColors.alternativeRed,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Name: ${user!.displayName ?? 'No Display Name'}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Email: ${user!.email!}",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "Email Verified? : ${user!.emailVerified.toString()}",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
