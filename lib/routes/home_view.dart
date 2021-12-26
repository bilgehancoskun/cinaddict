import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePage createState() => _HomePage();
}
class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child:  CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 25,
                    ),
                  ),
                  Text(
                    "@bilgehan",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Image.asset(
                "lib/assets/Google_Logo.png",
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.thumb_up_sharp,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.thumb_down_sharp,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.comment,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.navigation,color: Colors.white,),
                    Spacer(),
                    Icon(Icons.bookmark,color: Colors.white,)
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text(
                    "17 likes ",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    "dodo123",
                    style: AppTextStyle.darkboldTextStyle,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    "Wow what a beautiful logo",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:  CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 17,
                    ),
                  ),
                  Text(
                    "Add a comment...",
                    style: AppTextStyle.darkboldTextStyle,
                  ),
                ],
              ),
              Divider(
                color: AppColors.white,
                thickness: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child:  CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 25,
                    ),
                  ),
                  Text(
                    "@bilgehan",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Image.asset(
                "lib/assets/Google_Logo.png",
                fit: BoxFit.contain,
              ),
              SizedBox(height: 16,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.thumb_up_sharp,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.thumb_down_sharp,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.comment,color: Colors.white,),
                    SizedBox(width: 8,),
                    Icon(Icons.navigation,color: Colors.white,),
                    Spacer(),
                    Icon(Icons.bookmark,color: Colors.white,)
                  ],
                ),
              ),
              SizedBox(height: 8,),
              Row(
                children: [
                  Text(
                    "17 likes ",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Text(
                    "dodo123",
                    style: AppTextStyle.darkboldTextStyle,
                  ),
                  SizedBox(width: 16,),
                  Text(
                    "Wow what a beautiful logo",
                    style: AppTextStyle.lighterTextStyle,
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child:  CircleAvatar(
                      child: ClipOval(
                          child: Image.asset("lib/assets/cinaddict_logo.png")),
                      radius: 17,
                    ),
                  ),
                  Text(
                    "Add a comment...",
                    style: AppTextStyle.darkboldTextStyle,
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