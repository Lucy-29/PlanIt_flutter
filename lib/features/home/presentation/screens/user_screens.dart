import 'package:ems_1/common/widgets/show_guest_alert.dart';
import 'package:ems_1/core/themes/app_themes.dart';
import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/home/presentation/screens/calendar_screen.dart';
import 'package:ems_1/features/home/presentation/screens/create_event/create_event_screen.dart';
import 'package:ems_1/features/home/presentation/screens/events/events_screen.dart';
import 'package:ems_1/features/home/presentation/screens/settings/settings_screen.dart';
//import 'package:ems_1/features/home/presentation/screens/AddEventScreen.dart';
import 'package:ems_1/features/home/presentation/screens/calendar_screen.dart';
//import 'package:ems_1/features/home/presentation/screens/settings_screen.dart';
//import 'package:ems_1/features/home/presentation/screens/AddEventScreen.dart';
import 'package:ems_1/features/home/presentation/screens/calendar_screen.dart';
//import 'package:ems_1/features/home/presentation/screens/settings_screen.dart';
import 'package:ems_1/features/home/presentation/screens/user_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:ems_1/features/home/presentation/screens/favorite/favoriteScreen.dart';
import 'package:ems_1/features/home/presentation/screens/notifications_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    EventsScreen(),
    // Addeventscreen()
    Favoritescreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final isGuest = authState is Authenticated && authState.isGuest;

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
      Icon(Icons.event_available_outlined,
          size: 30, color: _selectedIndex == 2 ? _activeColor : _inActiveColor),
      Icon(
        Icons.favorite_outline,
        size: 30,
        color: _selectedIndex == 3 ? _activeColor : _inActiveColor,
      ),
      Icon(
        Icons.settings_outlined,
        size: 30,
        color: _selectedIndex == 4 ? _activeColor : _inActiveColor,
      ),
    ];

    return Scaffold(
      extendBody: true,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isGuest
              ? showGuestAlert(context)
              : Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const CreateEventScreen()));
        },
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
