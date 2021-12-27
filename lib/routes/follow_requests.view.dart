import 'package:cinaddict/utils/colors.dart';
import 'package:cinaddict/utils/styles.dart';
import 'package:flutter/material.dart';

class FollowRequests extends StatelessWidget {
  const FollowRequests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Follow Requests'),
        centerTitle: true,
      ),
      /*
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                child: CircleAvatar(
                  child: ClipOval(
                      child: Image.network('https://medya.dpu.edu.tr/files/2017/03/02/58b7d4e05708b/20170302094651.jpeg',fit: BoxFit.cover)
                  ),
                  radius: 24,
                ),
              ),

              Column(

              children: [
                Row(
                  children: [
                    Padding(padding:  const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                    child: Text(
                      'yunus_sarikaya ' // This should be username
                    )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(80.0, 0.0, 0, 0.0),
                      child: SizedBox(
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
                    ),
                    SizedBox(
                      height: 5, width: 5,),
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
                Row(
                  children: [
                    Padding(padding:  const EdgeInsets.fromLTRB(0, 0.0, 210, 0),
                        child: Text(
                            'Yunus Sarikaya' // This should be displayName
                        ))
                  ],

                )


              ],
              )

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 0, 12.0),
                child: CircleAvatar(
                  child: ClipOval(
                      child: Image.network('https://medya.dpu.edu.tr/files/2017/03/02/58b7d4e05708b/20170302094651.jpeg',fit: BoxFit.cover)
                  ),
                  radius: 24,
                ),
              ),

              Column(
                children: [
                  Row(
                    children: [
                      Padding(padding:  const EdgeInsets.fromLTRB(10.0, 0.0, 0, 0.0),
                          child: Text(
                              'yumus_sarikaya ',
                            // This should be username
                            style: TextStyle(color: Colors.white)

                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80.0, 0.0, 0, 0.0),
                        child: SizedBox(
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
                      ),
                      SizedBox(
                        height: 5, width: 5,),
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
                  Row(
                    children: [
                      Padding(padding:  const EdgeInsets.fromLTRB(0, 0.0, 210, 0),
                          child: Text(
                              'Yunus Sarikaya', // This should be displayName
                              style: TextStyle(color: Colors.white)
                          ))
                    ],

                  )


                ],
              )

            ],
          ),




        ]
      ),*/
      body:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Row(
                children:[Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: CircleAvatar(
                  child: ClipOval(
                      child: Image.network('https://medya.dpu.edu.tr/files/2017/03/02/58b7d4e05708b/20170302094651.jpeg',fit: BoxFit.cover)
                  ),
                  radius: 24,
                ),


              ),
                  Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[ Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                              'yunus_sarikaya', // This should be username
                              style: TextStyle(color: Colors.white),

                          ),
                      ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Yunus Sarikaya', // This should be displayName
                            style: TextStyle(color: Colors.white),
                          ),
                        )


                 ] )
                ],),


            Row(
              children:[
                Padding(padding: EdgeInsets.zero,

                    child: SizedBox(
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
                  ),
                  SizedBox(
                    height: 5, width: 5,),
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

              ]
            )

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Row(
                children:[Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://medya.dpu.edu.tr/files/2017/03/02/58b7d4e05708b/20170302094651.jpeg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),


                ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[ Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'yunus_sarikaya', // This should be username
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Yunus Sarikaya', // This should be displayName
                            style: TextStyle(color: Colors.white),
                          ),
                        )


                      ] )
                ],),


              Row(
                  children:[
                    Padding(padding: EdgeInsets.zero,

                      child: SizedBox(
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
                    ),
                    SizedBox(
                      height: 5, width: 5,),
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

                  ]
              )

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              Row(
                children:[Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: CircleAvatar(
                    child: ClipOval(
                        child: Image.network('https://medya.dpu.edu.tr/files/2017/03/02/58b7d4e05708b/20170302094651.jpeg',fit: BoxFit.cover)
                    ),
                    radius: 24,
                  ),


                ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[ Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          'yunus_sarikaya', // This should be username
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Text(
                            'Yunus Sarikaya', // This should be displayName
                            style: TextStyle(color: Colors.white),
                          ),
                        )


                      ] )
                ],),


              Row(
                  children:[
                    Padding(padding: EdgeInsets.zero,

                      child: SizedBox(
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
                    ),
                    SizedBox(
                      height: 5, width: 5,),
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

                  ]
              )

            ],
          )
        ],
      )
    );
  }
}
