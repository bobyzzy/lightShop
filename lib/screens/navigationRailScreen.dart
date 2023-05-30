import 'package:flutter/material.dart';
import 'package:light_shop/screens/constructorPrice.dart';
import 'package:light_shop/screens/favorite.dart';
import 'package:light_shop/screens/page3.dart';

class MyNavigationRailScreen extends StatefulWidget {
  const MyNavigationRailScreen({super.key});

  @override
  State<MyNavigationRailScreen> createState() => _MyNavigationRailScreenState();
}

class _MyNavigationRailScreenState extends State<MyNavigationRailScreen> {
  var _selectedIndex = 0;
  List<NavigationRailDestination> _buildDestination() {
    return [
      const NavigationRailDestination(
        icon: Icon(Icons.light_mode_outlined),
        selectedIcon: Icon(Icons.light_mode),
        label: Text('Конструктор'),
      ),
      // const NavigationRailDestination(
      //   icon: Icon(Icons.assignment_late_outlined),
      //   selectedIcon: Icon(Icons.assignment_late),
      //   label: Text('последний запрос'),
      // ),
      const NavigationRailDestination(
        icon: Icon(Icons.badge_outlined),
        selectedIcon: Icon(Icons.badge_rounded),
        label: Text('о нас'),
      ),
    ];
  }

  List<Widget> _buildScreen() {
    return [
      ConstructorPrice(),
      // FavoritePage(),
      const Page3(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          labelType: NavigationRailLabelType.none,
          extended: true,
          minExtendedWidth: 200,
          leading: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
          elevation: 10,
          destinations: _buildDestination(),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: IndexedStack(
              index: _selectedIndex,
              children: _buildScreen(),
            ),
          ),
        ),
      ],
    );
  }
}
