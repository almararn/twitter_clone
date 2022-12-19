import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/tweet_compose.dart';
import '../models/tweets.dart';
import '../services/api_service.dart';

class TweetsContainer extends StatefulWidget {
  const TweetsContainer({super.key});

  @override
  State<TweetsContainer> createState() => _TweetsContainerState();

  void getData() {
    _TweetsContainerState().getData();
  }
}

class _TweetsContainerState extends State<TweetsContainer> {
  List<Tweets>? tweets = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    tweets = await FetchTweets().getTweets();
    if (tweets != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double respWidth = MediaQuery.of(context).size.width * 0.3;
    return SingleChildScrollView(
      child: Column(
        children: [
          TweetCompose(voidCallback: getData),
          Visibility(
            visible: isLoaded,
            replacement: const Center(
              child: LinearProgressIndicator(minHeight: 2),
            ),
            child: ListView.builder(
              reverse: true,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: tweets!.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                      width: 0.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey,
                              child: Icon(
                                Icons.person,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text('Tweeter Name'),
                                    const SizedBox(width: 5),
                                    Text(
                                      '@tweeterhandle',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '•',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      '5h',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: respWidth,
                                  child: Text(
                                    tweets![index].text.toString(),
                                    //   'This box will display a user tweet. It can have multiple lines. But at the moment it is just a placeholder. This box will display a user tweet. It can have multiple lines. But at the moment it is just a placeholder.',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
