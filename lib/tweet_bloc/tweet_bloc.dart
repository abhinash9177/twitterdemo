import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterdemo/model/tweet_model.dart';
import 'package:twitterdemo/repository/boxes.dart';
import 'package:twitterdemo/repository/repository.dart';
import 'package:twitterdemo/tweet_bloc/tweet_state.dart';

class TweetBloc extends Cubit<TweetState> {
  TweetBloc() : super(TweetInitialState());

  void tweet({
    required Tweetmodel tweetModel,
  }) async {
    emit(TweetLoadingState());
    tweetBox.put(Random().nextInt(10000), tweetModel);

    emit(TweetLoadedState(data: []));
  }

  void gettweets() async {
    emit(TweetLoadingState());

    emit(TweetLoadedState(data: []));
  }
}
