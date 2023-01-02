import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/tweets_container.dart';
import '../services/api_service.dart';

class TweetCompose extends StatefulWidget {
  final VoidCallback voidCallback;
  const TweetCompose({super.key, required this.voidCallback});

  @override
  State<TweetCompose> createState() => _TweetComposeState();
}

class _TweetComposeState extends State<TweetCompose> {
  final _textInput = TextEditingController();
  bool isLoading = false;

  sendData() async {
    print(userId);
    var tweets = {'text': _textInput.text, 'userId': userId};
    if (_textInput.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await PostTweets().postTweets(tweets);
      _textInput.clear();
      Future.delayed(const Duration(milliseconds: 1000), () {
        widget.voidCallback();
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _textInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double respWidth = MediaQuery.of(context).size.width * 0.3 - 100;
    return Container(
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
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Home',
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: respWidth,
                          child: TextField(
                            controller: _textInput,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'What\'s happening?',
                              hintStyle: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 20,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.image_outlined,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 10),
                            Icon(Icons.gif,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 10),
                            Icon(Icons.bar_chart,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 10),
                            Icon(Icons.poll_outlined,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 10),
                            Icon(Icons.emoji_emotions_outlined,
                                color: Theme.of(context).primaryColorLight),
                            const SizedBox(width: 10),
                            Icon(Icons.location_on_outlined,
                                color: Theme.of(context).primaryColorLight),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: sendData,
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.blue,
                        ),
                        child: const Center(
                          child: Text(
                            'Tweet',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
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
                height: 20,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  Visibility(
                    visible: isLoading,
                    child: const LinearProgressIndicator(
                      minHeight: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
