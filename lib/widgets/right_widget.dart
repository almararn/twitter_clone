import 'package:flutter/material.dart';

class RightPanel extends StatelessWidget {
  const RightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                color: Theme.of(context).primaryColorLight,
              ),
              height: 45,
              width: 400,
              child: Row(
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.search,
                    color: Colors.black45,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Search Twitter',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: Theme.of(context).primaryColorLight,
              ),
              height: 650,
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Trends for you',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    trending('Trending'),
                    textTwoLines('SORE LOOSER', '3,127 Tweets'),
                    trending('Trending'),
                    textTwoLines('#RacistRoyalFamily', '4,614 Tweets'),
                    trending('Trending in Iceland'),
                    textTwoLines('Argentina', '3.02M Tweets'),
                    trending('Trending'),
                    textTwoLines('#ElonMuskIsAFascist', '2,258 Tweets'),
                    trending('Entertainment Trending'),
                    textTwoLines('#DisneyPlus', '4,298 Tweets'),
                    trending('Trending'),
                    textTwoLines('#MarvelStudios', '2,852 Tweets'),
                    trending('Trending in Politics'),
                    textTwoLines('Lukashenko', '8,232 Tweets'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column textTwoLines(big, small) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          big,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          small,
          style: const TextStyle(
            color: Colors.black45,
          ),
        ),
        const SizedBox(
          height: 12,
        )
      ],
    );
  }

  Row trending(text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black45,
          ),
        ),
        const Icon(
          Icons.more_horiz,
          color: Colors.black45,
        ),
      ],
    );
  }
}
