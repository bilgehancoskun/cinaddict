import 'package:cinaddict/models/user.dart';
import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> data = {};
  late bool isPrivate = widget.user.isPrivate;
  String? displayName;
  String? username;
  String? description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: AppColors.alternativeRed,
        actions: [
          SizedBox(
            child: TextButton(
              onPressed: (){
                _formKey.currentState!.save();
                data["displayName"]=displayName;
                data["username"]=username;
                data["description"]=description;
                data["IsPrivate"]=isPrivate;
                Navigator.pop(context, data);
              },
              child: Row(
                children: [
                  Text(
                    "Save Changes ",
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                  Icon(Icons.done,color: AppColors.white,)
                ],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Display Name: ",
                        style: AppTextStyle.lighterbiggerTextStyle,
                      ),
                      SizedBox(
                        width: 280,
                        child:TextFormField(
                            decoration: InputDecoration(
                              //fillColor: AppColors.darkGrey,
                              //filled: true,
                              hintText: '${widget.user.displayName}',
                              hintStyle: AppTextStyle.lightTextStyle,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.midGrey,
                                  width: 2.0,
                                ),
                                borderRadius:
                                BorderRadius.all(Radius.circular(0)),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onSaved: (value){
                              if(value == null){
                                displayName=widget.user.displayName;
                              }
                              else{
                                displayName=value;
                              }
                            },
                          ),
                      ),
                    ],
                  ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Username: ",
                      style: AppTextStyle.lighterbiggerTextStyle,
                    ),
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(
                          //fillColor: AppColors.darkGrey,
                          //filled: true,
                          hintText: '${widget.user.username}',
                          hintStyle: AppTextStyle.lightTextStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.midGrey,
                              width: 2.0,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onSaved: (value){
                          if(value == null){
                            username=widget.user.username;
                          }
                          else{
                            username=value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Description: ",
                      style: AppTextStyle.lighterbiggerTextStyle,
                    ),
                    SizedBox(
                      width: 280,
                      child: TextFormField(
                        decoration: InputDecoration(
                          //fillColor: AppColors.darkGrey,
                          //filled: true,
                          hintText: '${widget.user.description}',
                          hintStyle: AppTextStyle.lightTextStyle,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.midGrey,
                              width: 2.0,
                            ),
                            borderRadius:
                            BorderRadius.all(Radius.circular(0)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        onSaved: (value){
                          if(value == null){
                            description=widget.user.description;
                          }
                          else{
                            description=value;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Account Status (Private or not): ",
                      style: AppTextStyle.lighterbiggerTextStyle,
                    ),
                    Switch(
                      activeColor: Colors.green,
                      value: isPrivate,
                      onChanged:(value){
                        print(value);
                        setState(() {
                          isPrivate=value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
// User = widget.user
// Display Name: data['displayName']
// Username: data['username']
// Description: data['description']
// Private Account: data['isPrivate'] -> Bool (Switch ile yap)
//data['name'] = 'Bilgehan';
//Navigator.pop(context, data);
