import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/tweet_compose.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            TweetCompose(),
            TweetsContainer(),
          ],
        ),
      ),
    );
  }
}
