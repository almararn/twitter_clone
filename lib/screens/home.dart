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
  homeCallBack() {
    if (Settings.reset) {
      setState(() {
        Settings.screenIndex = 2;
        Settings.initialPage = true;
      });
      Settings.reset = false;
    } else {
      setState(() {
        Settings.screenIndex = 0;
        Settings.initialPage = false;
      });
    }
  }

  Future<void> _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getInt('user')) == null) {
      setState(() {
        Settings.screenIndex = 2;
      });
    } else {
      Settings.initialPage = false;
      Settings.userId = prefs.getInt('user') ?? 0;
    }
  }

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                visible: !Settings.initialPage && constraints.maxWidth > 600,
                child: NavigationLeft(
                  leftWidgetCallback: () {
                    setState(() {
                      Settings.screenIndex = 2;
                    });
                  },
                ),
              ),
              Visibility(
                visible: !Settings.initialPage,
                replacement: Flexible(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    width: constraints.maxWidth,
                    child: MiddleWidget(homeWidgetCallback: () {
                      homeCallBack();
                    }),
                  ),
                ),
                child: Expanded(
                  flex: 10,
                  child: MiddleWidget(homeWidgetCallback: () {
                    homeCallBack();
                  }),
                ),
              ),
              Visibility(
                replacement: SizedBox(
                  width: constraints.maxWidth > 600
                      ? Settings.initialPage
                          ? 0
                          : 50
                      : 0,
                ),
                visible: !Settings.initialPage && constraints.maxWidth > 1000,
                child: const Expanded(
                  flex: 8,
                  child: RightPanel(),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
