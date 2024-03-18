import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitterdemo/features/addtweet/add_tweet.dart';
import 'package:twitterdemo/features/post/post.dart';
import 'package:twitterdemo/repository/boxes.dart';
import 'package:twitterdemo/utils/space_widget.dart';
import 'package:twitterdemo/tweet_bloc/tweet_bloc.dart';
import 'package:twitterdemo/tweet_bloc/tweet_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TweetBloc>(context).gettweets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  addHeight(24),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.network(
                                    'https://www.w3schools.com/howto/img_avatar.png'),
                              )),
                          SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(50)),
                                child: Image.network(
                                    'https://static.vecteezy.com/system/resources/previews/018/930/695/original/twitter-logo-twitter-icon-transparent-free-free-png.png'),
                              )),
                          const SizedBox(
                              height: 40,
                              width: 40,
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  child: Icon(
                                    Icons.stars_outlined,
                                    color: Color(0xff4B9EEB),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<TweetBloc, TweetState>(
                      listener: (previous, state) {
                        if (state is TweetLoadedState) {
                          setState(() {});
                        }
                      },
                      builder: (context, state) {
                        if (state is TweetLoadingState) {
                          return const CircularProgressIndicator();
                        }
                        return tweetBox.isEmpty
                            ? empty()
                            : Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: ListView(
                                  children: List.generate(
                                      tweetBox.length,
                                      (index) => PostWidget(
                                            tweetModel: tweetBox.getAt(index),
                                            index: index,
                                          )),
                                ),
                              );
                      },
                    ),
                  ),
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff4B9EEB),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTweetScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget empty() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.file_copy_outlined,
              size: 55,
              color: Color(0xff4B9EEB),
            ),
            addHeight(24),
            const Text(
              'No Tweets Found!',
              style: TextStyle(),
            )
          ],
        ),
      );
}
