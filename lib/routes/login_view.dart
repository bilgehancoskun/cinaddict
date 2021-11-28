import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//login branch test

class LoginView extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginView> {

final _formKey = GlobalKey<FormState>();
String mail = "";
String password = "";
late int count;

@override
void initState() {
  // TODO: implement initState
  super.initState();
  count = 0;
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.all(50.0),//TODO DIMENSIONS
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 150,),
                SizedBox(
                  height: 200,
                  child: Image(
                      image:NetworkImage('https://www.linkpicture.com/q/cinaddict_logo-2.png'),
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height:48.0,
                        child:TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.dark_grey,
                          filled: true,
                          hintText: 'username or email',
                          hintStyle: lightTextStyle,

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mid_grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if(value == null) {
                            return 'E-mail field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'E-mail field cannot be empty';
                            }
                           // if(!EmailValidator.validate(trimmedValue)) {//TODO ADD email_validator 2.0.1 from pub.dev
                            //  return 'Please enter a valid email';
                           // }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if(value != null) {
                            mail = value;
                          }
                        },
                      ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height:48.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          fillColor: AppColors.dark_grey,
                          filled: true,
                          hintText: 'password',
                          hintStyle: lightTextStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.mid_grey,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,

                        validator: (value) {
                          if(value == null) {
                            return 'Password field cannot be empty';
                          } else {
                            String trimmedValue = value.trim();
                            if(trimmedValue.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            if(trimmedValue.length < 8) {
                              return 'Password must be at least 8 characters long';
                            }
                          }
                          return null;
                        },
                        onSaved: (value) {
                          if(value != null) {
                            password = value;
                          }
                        },
                      ),
                      ),
                    ),
                  ],
                ),
               // SizedBox(height: 5,),
                TextButton(
                  onPressed:() {
                    Navigator.pushNamed(context, '/signup');//TODO change to go to  help?

                  },
                  child: Text(
                    "Forgot password? Click here to get help.",
                    style: lighterTextStyle,
                  ),
                ),

              //  SizedBox(height: 0,),
                SizedBox(
                  width: 100.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {
                            //TODO
                            if(_formKey.currentState!.validate()) {
                              print('Mail: '+mail+"\nPassword: "+password);
                              _formKey.currentState!.save();
                              print('Mail: '+mail+"\nPassword: "+password);

                              //TODO  getUser();
                            }
                            else {
                              setState(() {
                                count+=1;
                               //TODO showAlertDialog('Error', 'You have tried your luck $count times');
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style:darkTextStyle,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppColors.red_secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 100,),

                TextButton(
                    onPressed:() {
                      Navigator.pushNamed(context, '/signup');
                   },
                  child: Text(
                    "Sign Up",
                  style:lighterTextStyle,
                ),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}