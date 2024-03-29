import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/tweet_compose.dart';
import '../services/api_service.dart';
import '../models/tweets.dart';
import '../settings.dart';

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
  bool isLoading = false;
  int tweetId = 0;
  int buttonId = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    tweets = await FetchTweets().getTweets();
    if (tweets != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  String showTime(int index) {
    final time =
        DateFormat('dd MMM').format(tweets![index].timestamp as DateTime);
    final currentTime = DateFormat('dd MMM').format(DateTime.now());
    if (time != currentTime) {
      return time;
    } else {
      final time =
          DateFormat('HH').format(tweets![index].timestamp as DateTime);
      final currentTime = DateFormat('HH').format(DateTime.now());
      int? currentHour = int.tryParse(currentTime);
      int? postedHour = int.tryParse(time);
      if (currentHour != postedHour) {
        return '${currentHour! - postedHour!}h';
      } else {
        final time =
            DateFormat('mm').format(tweets![index].timestamp as DateTime);
        final currentTime = DateFormat('mm').format(DateTime.now());
        int? currentMin = int.tryParse(currentTime);
        int? postedMin = int.tryParse(time);
        return '${currentMin! - postedMin!}m';
      }
    }
  }

  void pressedLike(int index) async {
    buttonId = index;
    setState(() {
      isLoading = true;
    });
    if (!isLiked(index)) {
      for (int i = 0; i < tweets![index].likes!.length; i++) {
        if (tweets![index].likes![i].userId == Settings.userId) {
          Settings.likeId = tweets![index].likes![i].likeId!;
        }
      }
      tweetId = tweets![index].tweetId!;
      var like = {
        'tweetId': tweetId,
        'userId': Settings.userId,
      };
      await PostLike().addLike(like);
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
        });
        getData();
      });
    } else {
      for (int i = 0; i < tweets![index].likes!.length; i++) {
        if (tweets![index].likes![i].userId == Settings.userId) {
          Settings.likeId = tweets![index].likes![i].likeId!;
        }
      }
      await PostLike().remoweLike(Settings.likeId);

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          isLoading = false;
        });
        getData();
      });
    }
  }

  bool isLiked(int index) {
    for (int i = 0; i < tweets![index].likes!.length; i++) {
      if (tweets![index].likes![i].userId == Settings.userId) {
        return true;
      }
    }
    return false;
  }

  void userSelect() {
    widget.tweetsCtrCallback(0);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          TweetCompose(
              voidCallback: getData, userSelectionCallback: userSelect),
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
                int img = tweets![index].user!.userId as int;
                return InkWell(
                  onTap: () {
                    widget
                        .tweetsCtrCallback(tweets![index].tweetId ?? index + 1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white10,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey,
                                  backgroundImage:
                                      AssetImage('assets/images/user$img.jpeg'),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Wrap(
                                        crossAxisAlignment:
                                            WrapCrossAlignment.center,
                                        children: [
                                          Text(tweets![index]
                                              .user!
                                              .firstName!
                                              .toString()),
                                          const SizedBox(width: 3),
                                          Text(tweets![index]
                                              .user!
                                              .lastName!
                                              .toString()),
                                          Visibility(
                                            visible: tweets![index]
                                                    .user!
                                                    .lastName! !=
                                                "",
                                            child: const SizedBox(width: 3),
                                          ),
                                          const Image(
                                            height: 15,
                                            width: 15,
                                            image: AssetImage(
                                                'assets/images/verified.gif'),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            tweets![index]
                                                .user!
                                                .handle!
                                                .toString(),
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
                                            showTime(index),
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
                                      Text(
                                        tweets![index].text.toString(),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Expanded(
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          alignment: WrapAlignment.spaceBetween,
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
                                                  tweets![index]
                                                      .comments!
                                                      .length
                                                      .toString(),
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
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () => isLoading
                                                      ? null
                                                      : pressedLike(index),
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    size: buttonId == index
                                                        ? isLoading
                                                            ? 18
                                                            : 22
                                                        : 22,
                                                  ),
                                                  color: isLiked(index)
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .primaryColorLight,
                                                ),
                                                Text(
                                                  tweets![index]
                                                      .likes!
                                                      .length
                                                      .toString(),
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
                                ),
                              ],
                            ),
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
