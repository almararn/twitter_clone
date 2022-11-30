import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          NavigationRail(
            unselectedLabelTextStyle: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 24,
            ),
            selectedLabelTextStyle: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            leading: const Padding(
              padding: EdgeInsets.only(right: 180, bottom: 10, top: 16),
              child: Image(
                image: AssetImage('images/twitter.png'),
                height: 30,
                width: 30,
                color: Colors.lightBlue,
              ),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            extended: true,
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index) =>
                setState(() => _selectedIndex = index),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_filled),
                selectedIcon: Icon(EvaIcons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.hash),
                selectedIcon: Icon(
                  EvaIcons.hash,
                  size: 28,
                ),
                label: Text('Explore'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.bellOutline),
                selectedIcon: Icon(EvaIcons.bell),
                label: Text('Notification'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.emailOutline),
                selectedIcon: Icon(EvaIcons.email),
                label: Text('Messages'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.bookmarkOutline),
                selectedIcon: Icon(EvaIcons.bookmark),
                label: Text('Bookmarks'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.fileTextOutline),
                selectedIcon: Icon(EvaIcons.fileText),
                label: Text('Lists'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.personOutline),
                selectedIcon: Icon(EvaIcons.person),
                label: Text('Profile'),
              ),
              NavigationRailDestination(
                icon: Icon(EvaIcons.plusCircleOutline),
                selectedIcon: Icon(EvaIcons.plusCircle),
                label: Text('More'),
              ),
            ],
          ),
          Expanded(
            child: Column(),
          ),
          Expanded(
            child: Column(),
          ),
        ],
      ),
    );
  }
}
