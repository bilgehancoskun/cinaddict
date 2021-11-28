import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpView extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpView> {

  int attemptCount = 0;
  String mail;
  String pass;
  String pass2;
  String userName;
  final _formKey = GlobalKey<FormState>();



  Future<void> signUpUser() async {
    final url = Uri.parse('http://altop.co/cs310/api.php');
    var body = {
      'call': 'signup',
      'mail': mail,
      'pass': pass,
      'username': userName
    };

    final response = await http.post(
      Uri.http(url.authority, url.path),
      headers: <String, String> {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
      },
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    if(response.statusCode >= 200 && response.statusCode < 300) {
      //Successful transmission
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for(var entry in jsonMap.entries) {
        print("${entry.key} ==> ${entry.value}");
      }

    }
    else if(response.statusCode >= 400 && response.statusCode < 500) {
      Map<String, dynamic> jsonMap = json.decode(response.body);

      for(var entry in jsonMap.entries) {
        print("${entry.key} ==> ${entry.value}");
      }

      showAlertDialog('WARNING', jsonMap['error_msg']);
    }
    else {
      print(response.body.toString());
      print(response.statusCode);
      showAlertDialog('WARNING', 'Response was not recognized');
    }
  }


  Future<void> showAlertDialog(String title, String message) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, //User must tap button
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SIGNUP',
          //style: kAppBarTitleTextStyle,
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        //padding: Dimen.regularPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [


            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Image.asset('images/cinaddict_logo.png',
                      width: MediaQuery.of(context).size.width/2.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[700],
                            filled: true,
                            hintText: 'E-mail',
                            //labelText: 'Username',
                            //labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            if(!EmailValidator.validate(value)) {
                              return 'The e-mail address is not valid';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            mail = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[700],
                            filled: true,
                            hintText: 'Username',
                            //labelText: 'Username',
                           // labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your username';
                            }
                            if(value.length < 4) {
                              return 'Username is too short';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            userName = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),


                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor:Colors.grey[700],
                            filled: true,
                            hintText: 'Password',
                            //labelText: 'Username',
                            //labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass = value;
                          },
                        ),
                      ),

                      SizedBox(width: 8.0),

                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          decoration: InputDecoration(
                            fillColor: Colors.grey[700],
                            filled: true,
                            hintText: 'Password (Repeat)',
                            //labelText: 'Username',
                           // labelStyle: kLabelLightTextStyle,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,

                          validator: (value) {
                            if(value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if(value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            pass2 = value;
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16,),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: 70,),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(

                          onPressed: () {

                            if(_formKey.currentState.validate()) {
                              _formKey.currentState.save();

                              if(pass != pass2) {
                                showAlertDialog("Error", 'Passwords must match');
                              }
                              else {
                                signUpUser();
                              }
                              //
                              setState(() {
                                attemptCount += 1;
                              });

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(content: Text('Signing up')));
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Sign Up',
                              //style: kButtonDarkTextStyle,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.red[700],

                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                      ),
                      SizedBox(width: 70,),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
