import 'package:ems_1/features/home/presentation/screens/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:ems_1/features/home/presentation/screens/calendar_screen.dart';
import 'package:ems_1/features/home/presentation/screens/favorite_screen.dart';
import 'package:ems_1/features/home/presentation/screens/settings_screen.dart';
import 'package:ems_1/features/home/presentation/screens/notifications_screen.dart';

class UserScreens extends StatefulWidget {
  const UserScreens({super.key});

  @override
  State<UserScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<UserScreens> {
  static final Color _activeColor = Color(0xFF206173);
  static final Color _inActiveColor = Colors.white;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    UserHomeScreen(),
    CalendarScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Widget> navBarItems = <Widget>[
      Icon(
        Icons.home_outlined,
        size: 30,
        color: _selectedIndex == 0 ? _activeColor : _inActiveColor,
      ),
      Icon(
        Icons.calendar_month_outlined,
        size: 30,
        color: _selectedIndex == 1 ? _activeColor : _inActiveColor,
      ),
      Icon(
        Icons.favorite_outline,
        size: 30,
        color: _selectedIndex == 2 ? _activeColor : _inActiveColor,
      ),
      Icon(
        Icons.settings_outlined,
        size: 30,
        color: _selectedIndex == 3 ? _activeColor : _inActiveColor,
      ),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        // backgroundColor: Color(0xFFF4F2EA),
        title: Text(
          'PLANIT',
          //   style: TextStyle(
          //       color: Color(0xFF206173),
          //       fontSize: 40,
          //       fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationsScreen()));
            },
            icon: Icon(
              Icons.notifications_outlined,
              // size: 30,
              // color: Color(0xFF206173),
            ),
          )
        ],
      ),
      // backgroundColor: Color(0xFFF4F2EA),
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: isDark ? Color(0xFF192428) : Color(0xFFF4F2EA),
        color: Color(0xFF206173),
        buttonBackgroundColor: isDark ? Color(0xFF192428) : Color(0xFFF4F2EA),
        height: 60,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        index: _selectedIndex,
        items: navBarItems,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
