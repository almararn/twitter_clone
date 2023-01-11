import 'package:flutter/material.dart';
import 'package:twitter_clone/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import 'package:twitter_clone/widgets/right_widget.dart';
import 'package:twitter_clone/widgets/left_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageNr = 0;
  bool initialPage = true;

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
        initialPage = false;
        Settings.userId = prefs.getInt('user') ?? 0;
      });
    }
  }

  homeCallBack() {
    if (Settings.reset) {
      setState(() {
        pageNr = 2;
        initialPage = true;
      });
      Settings.reset = false;
    } else {
      setState(() {
        pageNr = 0;
        initialPage = false;
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
          Visibility(
            visible: !initialPage && double.infinity > 600,
            child: NavigationLeft(
              leftWidgetCallback: () {
                setState(() {
                  pageNr = 2;
                });
              },
            ),
          ),
          Visibility(
            visible: !initialPage,
            replacement: Container(
              constraints: const BoxConstraints(maxWidth: 800),
              width: double.infinity,
              child: HomeWidget(
                  pageNr: pageNr,
                  homeWidgetCallback: () {
                    homeCallBack();
                  }),
            ),
            child: Expanded(
              flex: 10,
              child: HomeWidget(
                  pageNr: pageNr,
                  homeWidgetCallback: () {
                    homeCallBack();
                  }),
            ),
          ),
          Visibility(
            replacement: const SizedBox(
              width: double.infinity > 600 ? 50 : 0,
            ),
            visible: !initialPage && double.infinity > 1000,
            child: const Expanded(
              flex: 8,
              child: RightPanel(),
            ),
          ),
        ],
      ),
    );
  }
}
