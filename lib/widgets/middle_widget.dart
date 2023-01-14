import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/widgets/single_tweet.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';
import 'package:twitter_clone/widgets/user_selection.dart';
import 'package:twitter_clone/settings.dart';

class MiddleWidget extends StatefulWidget {
  final VoidCallback homeWidgetCallback;

  const MiddleWidget({super.key, required this.homeWidgetCallback});

  @override
  State<MiddleWidget> createState() => _MiddleWidgetState();
}

class _MiddleWidgetState extends State<MiddleWidget> {
  late List screens = [
    TweetsContainer(tweetsCtrCallback: _tweetsCallback),
    SingleTweet(singleTweetCallback: _singleTweetCallback),
    UserSelection(usersCtrCallback: _usersCallback),
    Container()
  ];

  void _usersCallback(int index) {
    if (index == 0) {
      widget.homeWidgetCallback();
    } else {
      Settings.userId = index;
      widget.homeWidgetCallback();
      _storeUser(index);
    }
  }

  void _tweetsCallback(int value) {
    if (value == 0) {
      setState(() {
        Settings.screenIndex = 2;
      });
    } else {
      Settings.tweetNumber = value;
      setState(() {
        Settings.screenIndex = 1;
      });
    }
  }

  void _singleTweetCallback() {
    setState(() {
      Settings.screenIndex = 0;
    });
  }

  Future<void> _storeUser(int user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('user', user);
  }

  Future<void> _loadPage() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getInt('user')) == null) {
      Settings.screenIndex = 2;
    } else {
      Settings.initialPage = false;
      Settings.userId = prefs.getInt('user') ?? 0;
      setState(() {
        Settings.screenIndex = 0;
      });
    }
  }

  @override
  void initState() {
    _loadPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0),
      child: PageView.builder(
          itemCount: 1,
          itemBuilder: (context, position) {
            return screens[Settings.screenIndex];
          }),
    );
  }
}
