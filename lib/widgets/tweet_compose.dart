import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../settings.dart';

class TweetCompose extends StatefulWidget {
  final VoidCallback? voidCallback;
  final VoidCallback? userSelectionCallback;
  const TweetCompose(
      {super.key, this.voidCallback, this.userSelectionCallback});

  @override
  State<TweetCompose> createState() => _TweetComposeState();
}

class _TweetComposeState extends State<TweetCompose> {
  final _textInput = TextEditingController();
  bool isLoading = false;

  sendData() async {
    var tweets = {'text': _textInput.text, 'userId': Settings.userId};
    if (_textInput.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await PostTweets().postTweets(tweets);
      _textInput.clear();
      Future.delayed(const Duration(milliseconds: 1000), () {
        widget.voidCallback!();
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
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
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            widget.userSelectionCallback!();
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: AssetImage(
                                'assets/images/user${Settings.userId}.jpeg'),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              TextField(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.image_outlined,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      const SizedBox(width: 10),
                                      Icon(Icons.gif,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      const SizedBox(width: 10),
                                      Icon(Icons.bar_chart,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      const SizedBox(width: 10),
                                      Icon(Icons.poll_outlined,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      const SizedBox(width: 10),
                                      Icon(Icons.emoji_emotions_outlined,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      const SizedBox(width: 10),
                                      Icon(Icons.location_on_outlined,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: sendData,
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
                                          'Tweet',
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
                      ],
                    ),
                  ),
                ],
              ),
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
