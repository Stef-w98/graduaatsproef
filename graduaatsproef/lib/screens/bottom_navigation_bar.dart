import 'package:flutter/material.dart';
import 'package:graduaatsproef/screens/account_management_screen.dart';
import 'package:graduaatsproef/screens/analytics_screen.dart';
import 'package:graduaatsproef/screens/checkinout_screen.dart';
import 'package:graduaatsproef/screens/home_screen.dart';

class NavigationPage {
  static const int homeScreen = 0;
  static const int checkInOutScreen = 1;
  static const int analytics = 2;
  static const int accountManagementScreen = 3;

  int index;
  String name;
  IconData icon;
  Widget content;

  NavigationPage(this.index, this.name, this.icon, this.content);
}

/// Controls the bottom navigation bar and the pages to be shown
class BottomNavigation extends StatefulWidget {
  const BottomNavigation(this.initialIndex, {Key? key}) : super(key: key);

  final int initialIndex;

  @override
  State<BottomNavigation> createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<BottomNavigation> {
  late int _currentIndex = widget.initialIndex;
  final PageController _pageController = PageController();
  late List<NavigationPage>
      _pages; // List of pages with data needed to handle the bottom navigation

  @override
  void initState() {
    super.initState();
    // The pages for in the bottom navigation bar
    _pages = [
      NavigationPage(NavigationPage.homeScreen, 'Home', Icons.home_outlined,
          const HomeScreen()),
      NavigationPage(NavigationPage.checkInOutScreen, 'Check In/Out',
          Icons.checklist_outlined, const CheckInOutScreen()),
      NavigationPage(NavigationPage.analytics, 'analytics',
          Icons.analytics_outlined, AnalyticsScreen()),
      NavigationPage(NavigationPage.accountManagementScreen, 'Account+',
          Icons.account_circle_outlined, const AccountManagementScreen()),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  /// Builds a list of the screens to be used in the bottom navigation
  List<Widget> _getScreens() {
    List<Widget> screens = [];
    for (NavigationPage navPage in _pages) {
      screens.add(navPage.content);
    }
    return screens;
  }

  /// Builds the list of [BottomNavigationBarItem] to use as bottom navigation
  List<BottomNavigationBarItem> _getNavBarItems() {
    List<BottomNavigationBarItem> navBarItems = [];
    for (NavigationPage navPage in _pages) {
      navBarItems.add(BottomNavigationBarItem(
        icon: Icon(navPage.icon),
        label: navPage.name,
      ));
    }
    return navBarItems;
  }

  void _changePage(int newIndex) {
    setState(() => _currentIndex = newIndex);
    _pageController.jumpToPage(newIndex);
  }

  void _updatePageIndex(int newIndex) {
    setState(() => _currentIndex = newIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _updatePageIndex,
        children: _getScreens(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF090F13),
        selectedItemColor: const Color(0xFF4B39EF),
        unselectedItemColor: const Color(0xFF95A1AC),
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: _changePage,
        items: _getNavBarItems(),
      ),
    );
  }
}
