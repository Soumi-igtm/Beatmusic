import 'package:beatmusic/ui/custom_colors.dart';
import 'package:beatmusic/view/tabs/create_tab.dart';
import 'package:beatmusic/view/tabs/hometab.dart';
import 'package:beatmusic/view/tabs/search_tab.dart';
import 'package:beatmusic/view/tabs/statistics_tab.dart';
import 'package:beatmusic/view/tabs/trending%20tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/remixicon.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  int _currentIndex = 0;
  List<String> headingList = ["My Music", "Statistics", "Create", "Trending","Search"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: false,
        title: Text(headingList[_currentIndex]),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Remix.user_line, color: kPrimaryColor))],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children:  const [
          HomeTab(),
          Statistics(),
          CreateTab(uid: ""),
          Trending(),
          SearchTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState((){
            _currentIndex = value;
          });
        },
        selectedItemColor: kPrimaryTextColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.comfortaa(fontSize: 10),
        unselectedLabelStyle: GoogleFonts.comfortaa(fontSize: 8),
        items:  [
           const BottomNavigationBarItem(
               icon: Icon(Remix.play_circle_fill),
              label: "My Music",
              backgroundColor: Colors.black,
           ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/graph.png", width: 25, color: _currentIndex == 1 ? kPrimaryTextColor : Colors.grey),
            label: "Statistics",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 26, color: _currentIndex == 2 ? kPrimaryTextColor : Colors.grey),
            label: "Create",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/trending-topic.png", width: 25, color: _currentIndex == 3 ? kPrimaryTextColor : Colors.grey),
            label: "Trending",
            backgroundColor: Colors.black,
          ),

          BottomNavigationBarItem(
            icon: Image.asset("assets/icons/search.png", width: 25, color: _currentIndex == 4 ? kPrimaryTextColor : Colors.grey),
            label: "Search",
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
