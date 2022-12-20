import 'dart:convert';

Tweet singleTweet(String str) => Tweet.fromJson(json.decode(str));

String tweetToJson(Tweet data) => json.encode(data.toJson());

class Tweet {
  Tweet({
    this.tweetId,
    this.text,
    this.comment,
    this.retweet,
    this.like,
    this.timestamp,
    this.user,
  });

  int? tweetId;
  String? text;
  String? comment;
  String? retweet;
  String? like;
  DateTime? timestamp;
  dynamic user;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        tweetId: json["tweetId"],
        text: json["text"],
        comment: json["comment"],
        retweet: json["retweet"],
        like: json["like"],
        timestamp: DateTime.parse(json["timestamp"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "tweetId": tweetId,
        "text": text,
        "comment": comment,
        "retweet": retweet,
        "like": like,
        "timestamp": timestamp,
        "user": user,
      };
}
