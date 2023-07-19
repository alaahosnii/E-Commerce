import 'package:ecommerce/ui/home/bottom_nav_icon.dart';
import 'package:ecommerce/ui/home/tabs/categories_tab.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController(text: '');
  var selectedIndex = 0;
  var isSelected = false;
  var tabs = [HomeTab(), CategoriesTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        // titleSpacing: 20,
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Image.asset('images/search.png'),
                  labelText: 'what do you search for?',
                  labelStyle: TextStyle(
                      fontSize: 15, color: Theme.of(context).primaryColor),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: ImageIcon(
                AssetImage('images/shopping_cart.png'),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          iconSize: 25,
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: BottomNavIcon('home', selectedIndex == 0),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: BottomNavIcon('categories', selectedIndex == 1),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: BottomNavIcon('wish', selectedIndex == 2),
                label: ''),
            BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: BottomNavIcon('profile', selectedIndex == 3),
                label: ''),
          ],
        ),
      ),
    );
  }
}
