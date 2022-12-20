import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import 'package:twitter_clone/widgets/right_widget.dart';
import '../widgets/left_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavigationLeft(),
          Expanded(
            flex: 10,
            child: HomeWidget(),
          ),
          Expanded(
            flex: 8,
            child: RightPanel(),
          ),
        ],
      ),
    );
  }
}
