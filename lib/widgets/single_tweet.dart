import 'package:flutter/material.dart';
import 'package:twitter_clone/services/api_service.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import '../models/tweet.dart';

class SingleTweet extends StatefulWidget {
  final VoidCallback singleTweetCallback;
  const SingleTweet({super.key, required this.singleTweetCallback});

  @override
  State<SingleTweet> createState() => _SingleTweetState();
}

class _SingleTweetState extends State<SingleTweet> {
  late Tweet singleTweet;
  bool isLoaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future dataBuilder() async {
    singleTweet = await FetchSingleTweet().getSingleTweet(tweetNumber);
    return singleTweet;
  }

  getData() async {
    singleTweet = await FetchSingleTweet().getSingleTweet(tweetNumber);
    print('get data called, tweet number is $tweetNumber');
    print('singleTweet data is: $singleTweet');
    setState(() {
      isLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: widget.singleTweetCallback,
            child: Container(
              height: 200,
              width: 400,
              // color: Colors.red,
              child: Text(singleTweet.text.toString()),
            ),
          ),
          GestureDetector(
            onTap: widget.singleTweetCallback,
            child: Container(
              height: 200,
              width: 400,
              // color: Colors.red,
              child: Text(singleTweet.comment.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
