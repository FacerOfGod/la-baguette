import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:baguette/core/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.navy.withOpacity(0.1),
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) => _onItemTapped(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.navy),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(FontAwesomeIcons.scaleUnbalanced),
            selectedIcon: Icon(
              FontAwesomeIcons.scaleUnbalanced,
              color: AppTheme.navy,
            ),
            label: 'Lois',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: AppTheme.navy),
            label: 'Députés',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppTheme.navy),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/laws')) return 1;
    if (location.startsWith('/deputies')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/laws');
        break;
      case 2:
        context.go('/deputies');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
