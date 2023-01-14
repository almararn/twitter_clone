import 'package:flutter/material.dart';
import 'package:twitter_clone/services/api_service.dart';
import 'package:twitter_clone/settings.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:intl/intl.dart';
import 'alert_dialogs.dart';

class SingleTweet extends StatefulWidget {
  final VoidCallback singleTweetCallback;
  const SingleTweet({super.key, required this.singleTweetCallback});

  @override
  State<SingleTweet> createState() => _SingleTweetState();
}

class _SingleTweetState extends State<SingleTweet> {
  final _textInput = TextEditingController();
  late Tweet singleTweet;
  bool isLoading = false;
  bool isLoaded = false;
  int userImg = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future dataBuilder() async {
    singleTweet = await FetchSingleTweet().getSingleTweet(Settings.tweetNumber);
    return singleTweet;
  }

  getData() async {
    singleTweet = await FetchSingleTweet().getSingleTweet(Settings.tweetNumber);
    userImg = singleTweet.userId as int;
    Future.delayed(const Duration(milliseconds: 100), () {
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
    await EraseTweet().deleteTweet(Settings.tweetNumber).then(
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
      'userId': Settings.userId,
    };

    if (_textInput.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await PostReply().addReply(comment);
      _textInput.clear();
      getData();
    }
  }

  sendLike() async {
    if (!isLiked()) {
      var like = {
        'tweetId': singleTweet.tweetId,
        'userId': Settings.userId,
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
      await PostLike().remoweLike(Settings.likeId);
      getData();
    }
  }

  bool isLiked() {
    for (int i = 0; i < singleTweet.likes!.length; i++) {
      if (singleTweet.likes![i].userId == Settings.userId) {
        Settings.likeId = (singleTweet.likes![i].likeId) as int;
        return true;
      }
    }
    return false;
  }

  bool allowDelete() {
    if (singleTweet.user!.userId != Settings.userId) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
                    decoration: Settings.boxDecoration,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onTap: widget.singleTweetCallback,
                            child: SizedBox(
                              width: 110,
                              height: 40,
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_back),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Tweet',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 45,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey,
                                backgroundImage: AssetImage(
                                    'assets/images/user$userImg.jpeg'),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text(singleTweet.user!.firstName
                                          .toString()),
                                      const SizedBox(width: 3),
                                      Text(singleTweet.user!.lastName
                                          .toString()),
                                      const SizedBox(width: 3),
                                      const Image(
                                        height: 15,
                                        width: 15,
                                        image: AssetImage(
                                            'assets/images/verified.gif'),
                                      ),
                                    ],
                                  ),
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
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, top: 30.0, bottom: 30.0),
                            child: Text(
                              singleTweet.text.toString(),
                              style: const TextStyle(fontSize: 22),
                            ),
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
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: singleTweet.likes!.isNotEmpty,
                                  child: Text(
                                    'Liked by:',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Wrap(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    children: [
                                      for (var like
                                          in singleTweet.likes!.reversed)
                                        Wrap(
                                          children: [
                                            Visibility(
                                              visible: singleTweet.likes!.last
                                                      .user!.handle !=
                                                  like.user!.handle,
                                              child: Text(
                                                ' • ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .primaryColorLight,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              like.user!.handle.toString(),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.blue,
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
                          const Divider(
                            color: Colors.white10,
                            thickness: 1,
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
                                        : showAlertDialog1(
                                            context, deleteTweet);
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
                    decoration: Settings.boxDecoration,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: IntrinsicHeight(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: AssetImage(
                                            'assets/images/user${Settings.userId}.jpeg'),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: TextField(
                                          expands: true,
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
                                ),
                                GestureDetector(
                                  onTap: () {
                                    sendReply();
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 85,
                                    decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
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
                            int img = singleTweet.comments![index].user!.userId
                                as int;
                            return Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.white10,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    IntrinsicHeight(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: AssetImage(
                                                'assets/images/user$img.jpeg'),
                                          ),
                                          const SizedBox(width: 15),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  crossAxisAlignment:
                                                      WrapCrossAlignment.center,
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
                                                    const SizedBox(width: 3),
                                                    const Image(
                                                      height: 15,
                                                      width: 15,
                                                      image: AssetImage(
                                                          'assets/images/verified.gif'),
                                                    ),
                                                    const SizedBox(width: 3),
                                                    Text(
                                                      singleTweet
                                                          .comments![index]
                                                          .user!
                                                          .handle
                                                          .toString(),
                                                      style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColorLight,
                                                      ),
                                                    ),
                                                  ],
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
                                                  //   width: respWidth,
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
                                          ),
                                        ],
                                      ),
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
}
