import 'dart:convert';
import '../models/tweet.dart';
import '../models/tweets.dart';
import 'package:http/http.dart' as http;

var addressAndPort = 'http://192.168.1.213:5291';

class FetchTweets {
  Future<List<Tweets>?> getTweets() async {
    var client = http.Client();
    var uri = Uri.parse('$addressAndPort/api/tweets');
    var response = await client.get(uri);
    //   print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tweetsFromJson(jsonString);
    } else {
      return null;
    }
  }
}

class FetchSingleTweet {
  Future<Tweet> getSingleTweet(i) async {
    var client = http.Client();
    var uri = Uri.parse('$addressAndPort/api/tweet/$i');
    var response = await client.get(uri);
    //   print('Fetched API: #$i');
    //   print(response.body);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return singleTweet(jsonString);
    } else {
      return response.statusCode as Tweet;
    }
  }
}

class EraseTweet {
  Future<bool> deleteTweet(i) async {
    var client = http.Client();
    var uri = Uri.parse('$addressAndPort/api/tweet/$i');
    var response = await client.delete(uri);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

class PostTweets {
  Future<http.Response> postTweets(dynamic object) async {
    return http.post(
      Uri.parse('$addressAndPort/api/tweets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(object),
    );
  }
}

class PostReply {
  Future<http.Response> addReply(dynamic object, int i) async {
    return http.put(
      Uri.parse('$addressAndPort/api/tweet/$i'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(object),
    );
  }
}
