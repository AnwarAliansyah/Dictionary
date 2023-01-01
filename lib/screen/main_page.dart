import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:study_app/controllers/dictionary_controller.dart';
import 'package:study_app/screen/favorite_page.dart';
import 'package:study_app/screen/history_page.dart';
import 'package:study_app/screen/home_screen.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {

  MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 1;

  List pages = [
    HistoryPage(),
    HomeScreen(),
    FavoritePage(),
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late bool _userLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = 1;
    Get.find<DictionaryController>().getIsFavorite();
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime = DateTime.now();

    Future<bool> showExitPopup() async {
      final difference = DateTime.now().difference(currentBackPressTime);
      final isExitWarning = difference >= Duration(seconds: 2);

      currentBackPressTime = DateTime.now();

      String message = "Tekan sekali lagi untuk keluar";

      if (isExitWarning) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT,
            msg: message,
            backgroundColor: Colors.black.withOpacity(.5),
            fontSize: 15);
        return false;
      } else {
        Fluttertoast.cancel();
        return true;
      }
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: Container(
          height: 50,
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 0.0,
            unselectedFontSize: 0.0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: _selectedIndex,
            onTap: onTapNav,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.access_time_filled),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: "Home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
