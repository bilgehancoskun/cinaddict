import 'package:cinaddict/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:cinaddict/routes/home_view.dart';
import 'package:cinaddict/routes/navigation_view.dart';
import 'package:cinaddict/routes/movies_view.dart';
import 'package:cinaddict/routes/profile_view.dart';
import 'package:cinaddict/routes/notification_view.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics/firebase_analytics.dart';



class Structure extends StatefulWidget {

  Structure({Key? key, required this.username}) : super(key: key);
  final String username;


  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  int currentIndex = 0;
  late List<Widget> pages = [
    HomePage(),
    NavigationPage(),
    MoviePage(),
    NotificationPage(),
    ProfileView(username:widget.username),

  ];

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: pages[currentIndex],
            bottomNavigationBar:BottomNavigationBar(type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.alternativeRed,
                selectedItemColor: AppColors.yellow,
                unselectedItemColor: AppColors.white,
                iconSize: 25,
                selectedFontSize: 15,
                unselectedFontSize: 10,
                //showSelectedLabels: true,
                currentIndex: currentIndex,
                onTap: (index) => setState(() => currentIndex =index),

                items:[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label:'Home',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.near_me_outlined),
                    label:'Navigation',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.local_movies_rounded),
                    label:'Movies',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label:'Notification',

                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.accessible_forward_rounded),
                    label:'Profile',

                  ),

                ])


    );
  }


}


