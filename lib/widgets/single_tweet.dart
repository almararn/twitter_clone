import 'package:flutter/material.dart';
import 'package:twitter_clone/services/api_service.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';
import '../models/tweet.dart';
import 'package:intl/intl.dart';

class SingleTweet extends StatefulWidget {
  final VoidCallback singleTweetCallback;
  const SingleTweet({super.key, required this.singleTweetCallback});

  @override
  State<SingleTweet> createState() => _SingleTweetState();
}

class _SingleTweetState extends State<SingleTweet> {
  final _textInput = TextEditingController();
  bool isLoading = false;
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
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        isLoaded = true;
        isLoading = false;
      });
    });
  }

  String showTime() {
    final time = DateFormat('HH:mm • dd MMM, yyyy')
        .format(singleTweet.timestamp as DateTime);
    return time;
  }

  deleteTweet() async {
    await EraseTweet().deleteTweet(tweetNumber).then(
      (value) {
        if (value) {
          widget.singleTweetCallback();
        }
      },
    );
  }

  sendReply() async {
    var comment = {
      'text': _textInput.text,
      'tweetId': singleTweet.tweetId,
      'userId': userId,
    };
    setState(() {
      isLoading = true;
    });
    if (_textInput.text.isNotEmpty) {
      await PostReply().addReply(comment);
      _textInput.clear();
      getData();
    }
  }

  sendLike() async {
    if (!isLiked()) {
      var like = {
        'tweetId': singleTweet.tweetId,
        'userId': userId,
      };
      setState(() {
        isLoading = true;
      });

      await PostLike().addLike(like);
      getData();
    } else {
      setState(() {
        isLoading = true;
      });
      await PostLike().remoweLike(likeId);
      getData();
    }
  }

  bool isLiked() {
    for (int i = 0; i < singleTweet.likes!.length; i++) {
      if (singleTweet.likes![i].userId == userId) {
        likeId = (singleTweet.likes![i].likeId) as int;
        return true;
      }
    }
    return false;
  }

  bool allowDelete() {
    if (singleTweet.user!.userId != userId) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double respWidth = MediaQuery.of(context).size.width * 0.3 - 100;
    return SingleChildScrollView(
      child: Visibility(
        visible: isLoaded,
        replacement: const Padding(
          padding: EdgeInsets.all(100.0),
          child: Padding(
            padding: EdgeInsets.only(right: 40.0),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
        child: isLoaded
            ? Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                        right: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          GestureDetector(
                            onTap: widget.singleTweetCallback,
                            child: Row(
                              children: [
                                const Icon(Icons.arrow_back),
                                Container(
                                  color: Colors.transparent,
                                  width: 20,
                                  height: 20,
                                ),
                                const Text(
                                  'Tweet',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                      Text(singleTweet.user!.firstName
                                          .toString()),
                                      const SizedBox(width: 3),
                                      Text(singleTweet.user!.lastName
                                          .toString()),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    singleTweet.user!.handle.toString(),
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 400,
                            child: Text(
                              singleTweet.text.toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                showTime(),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColorLight,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(
                                        text: singleTweet.likes?.length != null
                                            ? '${singleTweet.likes?.length.toString()} '
                                            : '0 '),
                                    TextSpan(
                                      text: ' Likes',
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Divider(
                            color: Theme.of(context).primaryColorLight,
                            thickness: 0.2,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.comment,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 20,
                                ),
                                Icon(
                                  Icons.repeat,
                                  color: Theme.of(context).primaryColorLight,
                                  size: 20,
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: isLoading ? null : sendLike,
                                      icon: Icon(
                                        Icons.favorite,
                                        size: isLoading ? 20 : 24,
                                      ),
                                      color: isLiked()
                                          ? Colors.red
                                          : Theme.of(context).primaryColorLight,
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  color: allowDelete()
                                      ? Theme.of(context).primaryColorLight
                                      : Colors.green,
                                  onPressed: () {
                                    allowDelete()
                                        ? showAlertDialog2(context)
                                        : showAlertDialog(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                        right: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                        bottom: BorderSide(
                          color: Theme.of(context).primaryColorLight,
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
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
                                  SizedBox(
                                    width: respWidth,
                                    child: TextField(
                                      controller: _textInput,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        hintText: 'Tweet your reply',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .primaryColorLight,
                                          fontSize: 20,
                                        ),
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      sendReply();
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),
                                        color: Colors.blue,
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Reply',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          children: [
                            const SizedBox(
                              height: 2,
                            ),
                            Visibility(
                              visible: isLoading,
                              child: const LinearProgressIndicator(
                                minHeight: 2,
                              ),
                            ),
                          ],
                        ),
                        ListView.builder(
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: singleTweet.comments?.length,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(singleTweet
                                                    .comments![index]
                                                    .user!
                                                    .firstName
                                                    .toString()),
                                                const SizedBox(width: 3),
                                                Text(singleTweet
                                                    .comments![index]
                                                    .user!
                                                    .lastName
                                                    .toString()),
                                                const SizedBox(width: 5),
                                                Text(
                                                  singleTweet.comments![index]
                                                      .user!.handle
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Replying to ',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                ),
                                                Text(
                                                  singleTweet.user!.handle
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.blue),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            SizedBox(
                                              width: respWidth,
                                              child: Text(
                                                singleTweet
                                                    .comments![index].text
                                                    .toString(),
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 15,
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
                      ],
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Delete", style: TextStyle(color: Colors.red)),
      onPressed: () {
        deleteTweet();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Tweet"),
      content: const Text(
          "Are you sure you want to delete this tweet?\nThis action cannot be undone."),
      actions: [
        continueButton,
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    Widget cancelButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Tweet"),
      content:
          const Text("You can't delete this tweet because it's not yours."),
      actions: [
        cancelButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}