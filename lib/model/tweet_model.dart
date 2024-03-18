import 'dart:io';

import 'package:hive/hive.dart';

part 'tweet_model.g.dart';

@HiveType(typeId: 1)
class Tweetmodel {
  Tweetmodel({
    required this.name,
    required this.id,
    required this.tweet,
    required this.image,
    required this.comments,
    required this.likes,
    required this.reply,
  });
  @HiveField(0)
  String name;

  @HiveField(1)
  int id;

  @HiveField(2)
  String tweet;

  @HiveField(3)
  String image;

  @HiveField(4)
  int comments;

  @HiveField(5)
  int likes;

  @HiveField(6)
  int reply;
}
