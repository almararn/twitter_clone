import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import '../widgets/middle_widget.dart';
import '../widgets/right_widget.dart';
import '../widgets/left_widget.dart';
import '../settings.dart';

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
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible:
                            !Settings.initialPage && constraints.maxWidth > 600,
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
                        visible: !Settings.initialPage &&
                            constraints.maxWidth > 1000,
                        child: const Expanded(
                          flex: 8,
                          child: RightPanel(),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: constraints.maxWidth < 600,
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white10,
                          width: 1,
                        ),
                      ),
                    ),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(EvaIcons.home, color: Colors.blue),
                        Icon(EvaIcons.hash, color: Colors.grey),
                        Icon(EvaIcons.bellOutline, color: Colors.grey),
                        Icon(EvaIcons.emailOutline, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
