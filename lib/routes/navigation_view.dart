import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget{
  @override
  _NavigationPage createState() => _NavigationPage();
}
class _NavigationPage extends State<NavigationPage>{
  int counter =0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigation Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network("https://img3.aksam.com.tr/imgsdisk/2021/11/17/t25_spider-man-no-way-home-ne-384.jpg",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
               padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Expanded(
                    child: Image.network("https://upload.wikimedia.org/wikipedia/tr/9/97/Joker_%28film%29.jpg",
                    width: MediaQuery.of(context).size.width/3.7,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.network("https://i.ytimg.com/vi/2u_9nLfs8SI/maxresdefault.jpg",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.network("https://i.ytimg.com/vi/ePpJDKfRAyM/movieposter.jpg"),
                ),
              ],
            ),
            Image.network("https://stayhipp.com/wp-content/uploads/2019/07/New.jpg")
          ],
        ),
      ),
    );
  }
}