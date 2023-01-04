import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/single_tweet.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';
import 'package:twitter_clone/widgets/user_selection.dart';

// ignore: must_be_immutable
class HomeWidget extends StatefulWidget {
  final VoidCallback homeWidgetCallback;
  int pageNr;
  HomeWidget(
      {super.key, required this.pageNr, required this.homeWidgetCallback});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

int tweetNumber = 0;

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
        userId = index;
        widget.homeWidgetCallback();
      });
    }
  }

  tweetsCallback(int value) {
    tweetNumber = value;
    setState(() {
      widget.pageNr = 1;
    });
  }

  singleTweetCallback() {
    setState(() {
      widget.pageNr = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 2,
        itemBuilder: (context, position) {
          return screens[widget.pageNr];
        });
  }
}
