import 'package:twitterdemo/model/tweet_model.dart';

abstract class TweetState {}

class TweetInitialState extends TweetState {}

class TweetLoadingState extends TweetState {}

class TweetLoadedState extends TweetState {
  final List<Tweetmodel> data;

  TweetLoadedState({required this.data});
}

class TweetErrorState extends TweetState {
  final String error;

  TweetErrorState({required this.error});
}
