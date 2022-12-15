import 'package:flutter/material.dart';

class TweetCompose extends StatefulWidget {
  const TweetCompose({super.key});

  @override
  State<TweetCompose> createState() => _TweetComposeState();
}

class _TweetComposeState extends State<TweetCompose> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  width: 300,
                  child: TextField(
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
                    Icon(Icons.gif, color: Theme.of(context).primaryColorLight),
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
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
