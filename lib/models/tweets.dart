import 'dart:convert';

List<Tweets> tweetsFromJson(String str) =>
    List<Tweets>.from(json.decode(str).map((x) => Tweets.fromJson(x)));

String tweetsToJson(List<Tweets> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tweets {
  Tweets({
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

  factory Tweets.fromJson(Map<String, dynamic> json) => Tweets(
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
        "timestamp": timestamp!.toIso8601String(),
        "user": user,
      };
}
