import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/settings.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import 'package:twitter_clone/widgets/right_widget.dart';
import '../widgets/left_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNr = 0;

  @override
  void initState() {
    super.initState();
    _loadPage();
  }

  Future<void> _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getInt('user')) == null) {
      setState(() {
        pageNr = 2;
      });
    } else {
      setState(() {
        Settings.userId = prefs.getInt('user') ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationLeft(
            leftWidgetCallback: () {
              setState(() {
                pageNr = 2;
              });
            },
          ),
          Expanded(
            flex: 10,
            child: HomeWidget(
                pageNr: pageNr,
                homeWidgetCallback: () {
                  setState(() {
                    pageNr = 0;
                  });
                }),
          ),
          const Expanded(
            flex: 8,
            child: RightPanel(),
          ),
        ],
      ),
    );
  }
}
