import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/tweet_compose.dart';
import '../models/tweets.dart';
import '../services/api_service.dart';

class TweetsContainer extends StatefulWidget {
  final Function(int i) tweetsCtrCallback;
  const TweetsContainer({super.key, required this.tweetsCtrCallback});

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
                return GestureDetector(
                  onTap: () {
                    widget.tweetsCtrCallback(index);
                  },
                  child: Container(
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
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '•',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '5h',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
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
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SizedBox(
                                    width: respWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.comment,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              size: 20,
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.repeat,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              size: 20,
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.favorite,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              size: 20,
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Wrap(
                                          spacing: 10,
                                          children: [
                                            Icon(
                                              Icons.share,
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              size: 20,
                                            ),
                                            Text(
                                              '0',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColorLight,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
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
