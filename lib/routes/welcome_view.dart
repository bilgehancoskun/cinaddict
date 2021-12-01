import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Padding(
      padding: EdgeInsets.all(30).copyWith(top: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage("lib/assets/cinaddict_logo.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(

              children: [
                Text('Welcome to cinaddict', style: AppTextStyle.welcomeTextStyle,),
                  SizedBox(
                    height: 16,
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/login");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Login',
                              style: AppTextStyle.darkTextStyle,
                            ),
                          ),
                          style: AppButtonStyle.primaryYellowButton,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  Flex(
                    direction: Axis.horizontal,
                    children:[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/signup");
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Signup',
                              style: AppTextStyle.whiteTextStyle,
                            ),
                          ),
                          style: AppButtonStyle.primaryRedButton,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          )
        ],
      ),
    )));
  }
}
