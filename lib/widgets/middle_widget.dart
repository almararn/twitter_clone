import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter_clone/widgets/single_tweet.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';
import 'package:twitter_clone/widgets/user_selection.dart';
import 'package:twitter_clone/settings.dart';

// ignore: must_be_immutable
class HomeWidget extends StatefulWidget {
  final VoidCallback homeWidgetCallback;
  int pageNr;
  HomeWidget(
      {super.key, required this.pageNr, required this.homeWidgetCallback});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late List screens = [
    TweetsContainer(tweetsCtrCallback: tweetsCallback),
    SingleTweet(singleTweetCallback: singleTweetCallback),
    UserSelection(usersCtrCallback: usersCallback),
  ];

  usersCallback(int index) {
    if (index == 0) {
      setState(() {
        widget.homeWidgetCallback();
      });
    } else {
      setState(() {
        Settings.userId = index;
        widget.homeWidgetCallback();
        _storeUser(index);
      });
    }
  }

  tweetsCallback(int value) {
    if (value == 0) {
      setState(() {
        widget.pageNr = 2;
      });
    } else {
      Settings.tweetNumber = value;
      setState(() {
        widget.pageNr = 1;
      });
    }
  }

  singleTweetCallback() {
    setState(() {
      widget.pageNr = 0;
    });
  }

  Future<void> _storeUser(int user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('user', user);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 1,
        itemBuilder: (context, position) {
          return screens[widget.pageNr];
        });
  }
}
