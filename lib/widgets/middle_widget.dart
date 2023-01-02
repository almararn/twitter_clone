import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/single_tweet.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

int tweetNumber = 0;

class _HomeWidgetState extends State<HomeWidget> {
  int _page = 0;

  late List screens = [
    TweetsContainer(tweetsCtrCallback: tweetsCallback),
    SingleTweet(singleTweetCallback: singleTweetCallback),
  ];

  tweetsCallback(int value) {
    tweetNumber = value;
    setState(() {
      _page = 1;
    });
  }

  singleTweetCallback() {
    setState(() {
      _page = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: 2,
        itemBuilder: (context, position) {
          return screens[_page];
        });
  }
}
