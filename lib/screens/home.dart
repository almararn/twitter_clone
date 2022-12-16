import 'package:flutter/material.dart';
import 'package:twitter_clone/widgets/middle_widget.dart';
import '../widgets/navigation.dart';

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
        children: [
          const NavigationLeft(),
          const Expanded(
            flex: 3,
            child: HomeWidget(),
          ),
          Expanded(
            flex: 1,
            child: Column(),
          ),
        ],
      ),
    );
  }
}
