import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/navigation.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text('Shake & Stir')),
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) => _onItemTapped(index, context),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.list_alt_outlined),
                  selectedIcon: Icon(Icons.list_alt),
                  label: Text('Browse'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.casino_outlined),
                  selectedIcon: Icon(Icons.casino),
                  label: Text('Random'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: child,
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.push(AppRoutes.random),
          child: const Icon(Icons.casino),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildNavItem(
                context: context,
                index: 0,
                icon: Icons.list,
                label: 'Browse',
              ),
              _buildNavItem(
                context: context,
                index: 1,
                icon: Icons.favorite,
                label: 'Favorites',
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = _calculateSelectedIndex(context) == index;
    return IconButton(
      icon: Icon(
        icon,
        color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
      ),
      onPressed: () => _onItemTapped(index, context),
      tooltip: label,
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).routeInformationProvider.value.uri.toString();
    if (location.startsWith(AppRoutes.favorites)) return 1;
    if (location.startsWith(AppRoutes.random)) return 2;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.initial);
        break;
      case 1:
        context.go(AppRoutes.favorites);
        break;
      case 2:
        context.push(AppRoutes.random);
        break;
    }
  }
}