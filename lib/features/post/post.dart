import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:twitterdemo/features/home_screen/home_screen.dart';
import 'package:twitterdemo/model/tweet_model.dart';
import 'package:twitterdemo/repository/boxes.dart';
import 'package:twitterdemo/utils/space_widget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key, required this.tweetModel, required this.index});
  final Tweetmodel tweetModel;
  final int index;
  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tweetModel = widget.tweetModel;
  }

  Tweetmodel? tweetModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 55,
              width: 55,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.network(
                    'https://www.w3schools.com/howto/img_avatar.png'),
              )),
          addWidth(16),
          tweetBody()
        ],
      ),
    );
  }

  Widget tweetBody() => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title(),
            addHeight(4),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //'Twitter, Inc. was an American social media company based in San Francisco, California. The company operated the social networking service Twitter and previously the Vine short video app and Periscope livestreaming service',
                    tweetModel!.tweet,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: const TextStyle(
                        color: Color(0xff141619),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  addHeight(4),
                  Container(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: Image.memory(convertBase64(tweetModel!.image)))
                ],
              ),
            ),
            addHeight(4),
            counts(),
          ],
        ),
      );

  Widget counts() => Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 120),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          value(Icons.chat, widget.index),
          value(Icons.replay, tweetModel!.reply),
          value(Icons.favorite_border, tweetModel!.likes),
          GestureDetector(
              onTap: () {
                tweetBox.deleteAt(widget.index).then((value) => Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (context, __, _) => const HomeScreen(),
                          transitionDuration: Duration.zero),
                    ));
                setState(() {});
              },
              child: delete(Icons.delete, tweetModel!.comments))
        ]),
      );

  Widget value(IconData icon, int value) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xff687684),
        ),
        addWidth(4),
        Text(
          value.toString(),
          style: const TextStyle(
              color: Color(0xff687684),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }

  Widget delete(IconData icon, int value) {
    return Icon(
      icon,
      color: const Color(0xff687684),
    );
  }

  Row title() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          tweetModel!.name,
          style: const TextStyle(
              color: Color(0xff141619),
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        addWidth(4),
        Text(
          '@${tweetModel!.name.toLowerCase()}',
          style: const TextStyle(
              color: Color(0xff687684),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        addWidth(4),
        const Text(
          '12h',
          style: TextStyle(
              color: Color(0xff687684),
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  convertBase64(String data) {
    Uint8List bytes;
    bytes = const Base64Decoder().convert(data);
    return bytes;
  }
}
