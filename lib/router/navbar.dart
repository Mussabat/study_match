import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<Widget> _destinations = [
  const NavigationDestination(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const NavigationDestination(
    icon: Icon(Icons.search),
    label: 'Search',
  ),
  const NavigationDestination(
    icon: Icon(Icons.explore),
    label: 'Explore',
  ),
  const NavigationDestination(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];

class ScaffoldWithNavBar extends StatefulWidget {
  const ScaffoldWithNavBar({super.key, required this.child});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  void _changeDest(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        context.go('/explore');
        break;
      case 3:
        context.go('/profile');
        break;
      default:
        context.go('/home');
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        selectedIndex: _currentIndex,
        onDestinationSelected: _changeDest,
      ),
      body: widget.child,
    );
  }
}
