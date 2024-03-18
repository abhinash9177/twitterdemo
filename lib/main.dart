import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:twitterdemo/features/home_screen/home_screen.dart';
import 'package:twitterdemo/model/tweet_model.dart';
import 'package:twitterdemo/repository/boxes.dart';
import 'package:twitterdemo/tweet_bloc/tweet_bloc.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TweetmodelAdapter());
  tweetBox = await Hive.openBox<Tweetmodel>('tweetsmodel');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TweetBloc()),
      ],
      child: MaterialApp(
        title: 'Twitter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
