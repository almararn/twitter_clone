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
      Future.delayed(const Duration(milliseconds: 500), () {
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
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
          right: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
          bottom: BorderSide(
            color: Colors.white10,
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 40,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const SizedBox(
                                height: 60,
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
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 185,
                                    child: Wrap(
                                      children: [
                                        Icon(Icons.image_outlined,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        const SizedBox(width: 8),
                                        Icon(Icons.gif,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        const SizedBox(width: 8),
                                        Icon(Icons.bar_chart,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        const SizedBox(width: 8),
                                        Icon(Icons.poll_outlined,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        const SizedBox(width: 8),
                                        Icon(Icons.emoji_emotions_outlined,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                        const SizedBox(width: 8),
                                        Icon(Icons.location_on_outlined,
                                            color: Theme.of(context)
                                                .primaryColorLight),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        sendData();
                                        FocusScope.of(context).unfocus();
                                      },
                                      child: Container(
                                        height: 35,
                                        width: 85,
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
                height: 10,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 8,
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
