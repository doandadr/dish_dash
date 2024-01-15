import 'dart:io';

import 'package:dish_dash/common/style.dart';
import 'package:dish_dash/ui/restaurant_list_page.dart';
import 'package:dish_dash/ui/search_page.dart';
import 'package:dish_dash/ui/settings_page.dart';
import 'package:dish_dash/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const SearchPage(),
    const SettingsPage()
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Platform.isIOS ? CupertinoIcons.house : Icons.food_bank_outlined,
        ),
        label: RestaurantListPage.restaurantListTitle),
    BottomNavigationBarItem(
        icon: Icon(
          Platform.isIOS ? CupertinoIcons.search : Icons.search,
        ),
        label: SearchPage.searchTitle),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: SettingsPage.settingsTitle,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: primaryVariantColor,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: primaryColor,
        inactiveColor: primaryVariantColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _buildAndroid, iosBuilder: _buildIos);
  }
}