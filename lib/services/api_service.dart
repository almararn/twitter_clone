import 'dart:convert';
import '../models/tweets.dart';
import 'package:http/http.dart' as http;

class FetchTweets {
  Future<List<Tweets>?> getTweets() async {
    var client = http.Client();
    var uri = Uri.parse('http://192.168.1.213:5291/api/tweets');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return tweetsFromJson(jsonString);
    } else {
      return null;
    }
  }
}

class PostTweets {
  Future<http.Response> postTweets(dynamic object) async {
    return http.post(
      Uri.parse('http://192.168.1.213:5291/api/tweets'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(object),
    );
  }
}
