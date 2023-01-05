import 'dart:convert';

Tweet singleTweet(String str) => Tweet.fromJson(json.decode(str));

String tweetToJson(Tweet data) => json.encode(data.toJson());

class Tweet {
  Tweet({
    this.tweetId,
    this.text,
    this.timestamp,
    this.userId,
    this.user,
    this.likes,
    this.comments,
  });

  int? tweetId;
  String? text;
  DateTime? timestamp;
  int? userId;
  User? user;
  List<Like>? likes;
  List<Comment>? comments;

  factory Tweet.fromJson(Map<String, dynamic> json) => Tweet(
        tweetId: json["tweetId"],
        text: json["text"],
        timestamp: DateTime.parse(json["timestamp"]),
        userId: json["userId"],
        user: User.fromJson(json["user"]),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tweetId": tweetId,
        "text": text,
        "timestamp": timestamp!.toIso8601String(),
        "userId": userId,
        "user": user!.toJson(),
        "likes": List<dynamic>.from(likes!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment({
    this.commentId,
    this.text,
    this.timestamp,
    this.tweetId,
    this.userId,
    this.user,
  });

  int? commentId;
  String? text;
  DateTime? timestamp;
  int? tweetId;
  int? userId;
  User? user;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["commentId"],
        text: json["text"],
        timestamp: DateTime.parse(json["timestamp"]),
        tweetId: json["tweetId"],
        userId: json["userId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "text": text,
        "timestamp": timestamp!.toIso8601String(),
        "tweetId": tweetId,
        "userId": userId,
        "user": user!.toJson(),
      };
}

class User {
  User({
    this.userId,
    this.firstName,
    this.lastName,
    this.handle,
  });

  int? userId;
  String? firstName;
  String? lastName;
  String? handle;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        handle: json["handle"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "handle": handle,
      };
}

class Like {
  Like({
    this.likeId,
    this.tweetId,
    this.userId,
    this.user,
  });

  int? likeId;
  int? tweetId;
  int? userId;
  User? user;

  factory Like.fromJson(Map<String, dynamic> json) => Like(
        likeId: json["likeId"],
        tweetId: json["tweetId"],
        userId: json["userId"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "likeId": likeId,
        "tweetId": tweetId,
        "userId": userId,
        "user": user!.toJson(),
      };
}
