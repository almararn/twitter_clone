import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:twitter_clone/models/users.dart';
import 'package:twitter_clone/services/api_service.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';

import '../settings.dart';

class NavigationLeft extends StatefulWidget {
  final VoidCallback leftWidgetCallback;
  const NavigationLeft({
    Key? key,
    required this.leftWidgetCallback,
  }) : super(key: key);

  @override
  State<NavigationLeft> createState() => _NavigationLeftState();
}

class _NavigationLeftState extends State<NavigationLeft> {
  int _selectedIndex = 0;
  List<Users>? user = [];
  bool isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    user = await FetchUsers().getAllUsers();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 22, top: 20, bottom: 10),
            child: Image(
              image: AssetImage('assets/images/twitter.png'),
              height: 30,
              width: 30,
              color: Colors.lightBlue,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: SizedBox(
                height: 600,
                child: NavigationRail(
                  indicatorColor: Colors.red,
                  unselectedLabelTextStyle: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 18,
                  ),
                  selectedLabelTextStyle: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
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
              ),
            ),
          ),
/*           Padding(
            padding: const EdgeInsets.only(left: 18, bottom: 10, top: 10),
            child: Container(
              height: 50,
              width: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.blue,
              ),
              child: const Center(
                  child: Text(
                'Tweet',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
            ),
          ), */
          InkWell(
            onTap: widget.leftWidgetCallback,
            hoverColor: const Color.fromARGB(10, 33, 149, 243),
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 18, bottom: 15, right: 18, top: 15),
                child: isLoaded
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: AssetImage(
                                'assets/images/user${Settings.userId}.jpeg'),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    user![Settings.userId - 1]
                                        .firstName
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    user![Settings.userId - 1]
                                        .lastName
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                user![Settings.userId - 1].handle.toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    : const SizedBox(
                        height: 40,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
