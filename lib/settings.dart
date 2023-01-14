import 'package:flutter/material.dart';

class Settings {
  static int userId = 1;
  static int likeId = 0;
  static int tweetNumber = 1;
  static int screenIndex = 3; // á að vera 3
  static bool initialPage = true;
  static bool reset = false;
  static bool scrSizeSmall = true;
  static BoxDecoration boxDecoration = const BoxDecoration(
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
  );
}
