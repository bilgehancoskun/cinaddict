import 'dart:ui';

import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  // TODO: Create a welcome view
  void buttonPressedLogin(){
    Navigator.pushNamed(context, "/login");
  }
  void buttonPressedSignup(){
    Navigator.pushNamed(context, "/login");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(
          "Welcome",
          style:TextStyle(
            fontSize: 24.0
          ),

        ),
        centerTitle: true,
      ),
      body:Center(
        child:Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/cinaddict_logo.png"),
              ),
              SizedBox(height: 8,),
              Text(
                "Welcome to Cinaddict",
                style:TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height:16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: buttonPressedLogin,
                      child: Text(
                        "Login",
                      )
                  ),
                  OutlinedButton(
                      onPressed: buttonPressedSignup,
                      child: Text(
                        "Signup",
                      )
                  )
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
