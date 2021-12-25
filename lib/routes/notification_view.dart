import 'package:flutter/material.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:cinaddict/utils/colors.dart';
class NotificationPage extends StatefulWidget{
  @override
  _NotificationPage createState() => _NotificationPage();
}
class _NotificationPage extends State<NotificationPage>{
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,

      ),
        body:Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 10.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.asset("lib/assets/cinaddict_logo.png")
                    ),
                    radius: 24,
                  ),
                ),
                Column(

                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(7.0, 0.0, 0, 0.0),
                      child: Text(
                        "Follow Requests",
                        style: AppTextStyle.lighterbiggerboldTextStyle,

                      ),
                    ),
                    Padding(

                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 0.0),
                      child: Text(
                        "daily_movies + 308 more",
                        style: AppTextStyle.lighterTextStyle,

                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 12.0, 0, 5.0),
                  child: Text(
                    "Today",
                    style: AppTextStyle.lighterbiggerboldTextStyle,

                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4207.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  children: [

                    Row(
                      children: [
                        Padding(

                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                          child: Text(
                            "peter_williams started following you.",
                            style: AppTextStyle.lighterTextStyle,

                          ),

                        ),
                        Padding(

                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0),
                          child: Text(
                            "7h",
                            style: AppTextStyle.lightestsmallTextStyle,

                          ),
                        ),
                        SizedBox(
                          height: 23,
                          child: OutlinedButton(
                            onPressed: (){},
                            child: Text(
                              "Follow",
                              style: AppTextStyle.darksmallerTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4210.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                              child: Text(
                                "movie_loverr mentioned you in a comment:",
                                style: AppTextStyle.lighterTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),

                            ),
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 15.0, 10.0),
                              child: Text(
                                "8h",
                                style: AppTextStyle.lightestsmallTextStyle,

                              ),
                            ),

                          ],
                        ),
                        Row(

                          children: [
                            Padding(

                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                              child: Text(
                                "@moviess @zendayafan @dunemovie",
                                style: AppTextStyle.lighterTextStyle,

                              ),

                            ),


                          ],

                        ),
                      ],


                    ),


                  ],
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child:   Image.network('https://www.linkpicture.com/q/IMG_2031-2_1.jpg',fit: BoxFit.cover),

                  ),
                ),


              ],

            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4209.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                              child: Text(
                                "anime_2004 liked your photo.",
                                style: AppTextStyle.lighterTextStyle,

                              ),

                            ),
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 90.0, 10.0),
                              child: Text(
                                "9h",
                                style: AppTextStyle.lightestsmallTextStyle,

                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child:Image.network('https://www.linkpicture.com/q/IMG_2037-2_1.jpg',fit: BoxFit.cover),
                  ),
                ),


              ],

            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 12.0, 0, 5.0),
                  child: Text(
                    "Yesterday",
                    style: AppTextStyle.lighterbiggerboldTextStyle,

                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4212.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  children: [

                    Row(
                      children: [
                        Padding(

                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                          child: Text(
                            "selena_ requested to follow you.",
                            style: AppTextStyle.lighterTextStyle,

                          ),

                        ),
                        Padding(

                          padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
                          child: Text(
                            "1d",
                            style: AppTextStyle.lightestsmallTextStyle,

                          ),
                        ),
                        SizedBox(
                          height: 25,
                          width: 69,
                          child: OutlinedButton(
                            onPressed: (){},
                            child: Text(
                              "Confirm",
                              style: AppTextStyle.darksmallestTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                          width: 5,),
                        SizedBox(
                          height: 25,
                          width: 62,
                          child: OutlinedButton(
                            onPressed: (){},
                            child: Text(
                              "Delete",
                              style: AppTextStyle.darksmallestTextStyle,
                            ),
                            style: ButtonStyle(

                              backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 12.0, 0, 5.0),
                  child: Text(
                    "This Week",
                    style: AppTextStyle.lighterbiggerboldTextStyle,

                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4208.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  children: [

                    Row(
                      children: [
                        Padding(

                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                          child: Text(
                            "moviess_2020 started following you.",
                            style: AppTextStyle.lighterTextStyle,

                          ),

                        ),
                        Padding(

                          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0),
                          child: Text(
                            "7h",
                            style: AppTextStyle.lightestsmallTextStyle,

                          ),
                        ),
                        SizedBox(
                          height: 23,
                          child: OutlinedButton(
                            onPressed: (){},
                            child: Text(
                              "Follow",
                              style: AppTextStyle.darksmallerTextStyle,
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(AppColors.lightestGrey),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://www.linkpicture.com/q/IMG_4214_1.jpg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                              child: Text(
                                "maria_cara commented: Wow perfect!!",
                                style: AppTextStyle.lighterTextStyle,

                              ),

                            ),
                            Padding(

                              padding: const EdgeInsets.fromLTRB(10.0, 0.0, 35.0, 10.0),
                              child: Text(
                                "8h",
                                style: AppTextStyle.lightestsmallTextStyle,

                              ),
                            ),

                          ],
                        ),

                      ],

                    ),

                  ],
                ),
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    child:   Image.network('https://www.linkpicture.com/q/IMG_2032-2_1.jpg',fit: BoxFit.cover),

                  ),
                ),


              ],

            ),


          ],

        )

    );
  }
}