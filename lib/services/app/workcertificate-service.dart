import 'dart:convert';

import 'package:http/http.dart';

Future<List<Post>> getPosts() async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
  final response =
      await get(url, headers: {"Content-Type": "application/json"});
  final List body = json.decode(response.body);
  print(body);
  return body.map((e) => Post.fromJson(e)).toList();
}

class Post {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Post({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Post.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
