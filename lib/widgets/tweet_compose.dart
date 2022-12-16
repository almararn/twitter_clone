import 'package:flutter/material.dart';

class TweetCompose extends StatefulWidget {
  const TweetCompose({super.key});

  @override
  State<TweetCompose> createState() => _TweetComposeState();
}

class _TweetComposeState extends State<TweetCompose> {
  @override
  Widget build(BuildContext context) {
    double respWidth = MediaQuery.of(context).size.width * 0.4 - 100;
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
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              'Home',
              style: TextStyle(
                  color: Theme.of(context).primaryColorLight,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
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
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
