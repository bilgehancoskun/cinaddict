import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Welcome",
            style: TextStyle(fontSize: 24.0),
          ),
          centerTitle: true,
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: AssetImage("assets/cinaddict_logo.png"),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Welcome to Cinaddict",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 64,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                  OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child:
                          Text("Signup", style: TextStyle(color: Colors.white)))
                ],
              )
            ],
          ),
        )));
  }
}
