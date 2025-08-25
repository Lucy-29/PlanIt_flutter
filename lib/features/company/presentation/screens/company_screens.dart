import 'package:ems_1/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:ems_1/features/company/presentation/screens/company_events_screen.dart';
import 'package:ems_1/features/company/presentation/screens/company_profile_screen.dart';
import 'package:ems_1/features/company/presentation/screens/company_statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyScreens extends StatefulWidget {
  const CompanyScreens({super.key});

  @override
  State<CompanyScreens> createState() => _UserScreensState();
}

class _UserScreensState extends State<CompanyScreens> {
  static final Color _activeColor = Color(0xFF206173);
  static final Color _inActiveColor = Colors.white;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    CompanyProfileScreen(),
    CompanyEventsScreen(),
    CompanyStatisticsScreen()
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
      Icon(Icons.event_available_outlined,
          size: 30, color: _selectedIndex == 2 ? _activeColor : _inActiveColor),
      Icon(
        Icons.star_border_outlined,
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     isGuest
      //         ? showGuestAlert(context)
      //         : Navigator.of(context).push(
      //             MaterialPageRoute(builder: (_) => const CreateEventScreen()));
      //   },
      //   child: Icon(Icons.add),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(20),
      //   ),
      // ),
    );
  }
}
