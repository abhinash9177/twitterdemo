import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitterdemo/features/home_screen/home_screen.dart';
import 'package:twitterdemo/model/tweet_model.dart';
import 'package:twitterdemo/utils/space_widget.dart';
import 'package:twitterdemo/tweet_bloc/tweet_bloc.dart';

class AddTweetScreen extends StatefulWidget {
  const AddTweetScreen({super.key});

  @override
  State<AddTweetScreen> createState() => _AddTweetScreenState();
}

class _AddTweetScreenState extends State<AddTweetScreen> {
  bool selectimage = false;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String imgname = '';
  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.file == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _image = File(response.file!.path);
        }
      });
    } else {
      setState(() {
        _image = null;
      });
    }
  }

  void _setImageFileListFromFile(XFile? value) {
    _image = value == null ? null : File(value.path);
  }

  bool imageUploadLoading = false;
  Future getImage(BuildContext context) async {
    final XFile? pickedFile = await _picker.pickImage(
        preferredCameraDevice: CameraDevice.front,
        source: ImageSource.camera,
        imageQuality: 60);
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressQuality: 80,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop your image',
              toolbarColor: const Color(0xff4B9EEB),
              toolbarWidgetColor: const Color(0xffFFFFFF),
              activeControlsWidgetColor: const Color(0xff4B9EEB),
              backgroundColor: const Color(0xff4B9EEB),
              initAspectRatio: CropAspectRatioPreset.square,
              // hideBottomControls: false,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Crop your image',
            minimumAspectRatio: 1.1,
            rectX: 200,
            rectY: 200,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _image = File(croppedFile.path);
          imgname = 'imageName.jpg';
        });
      } else {
        setState(() {
          _image = null;
        });
        if (kDebugMode) debugPrint('image not croped.');
      }
    }
  }

  final TextEditingController _tweet = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TweetBloc bloc = BlocProvider.of<TweetBloc>(context);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                header(),
                textBox(),
                Container(child: capturedImage())
              ],
            ),
          ),
        ),
      )),
      bottomNavigationBar: Container(
        height: 55,
        decoration: const BoxDecoration(
            color: Colors.white,
            border:
                Border(top: BorderSide(width: 1, color: Color(0xffE7ECF0)))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    getImage(context);
                  },
                  child: const Icon(
                    Icons.image_outlined,
                    color: Color(0xff4B9EEB),
                  )),
              addWidth(16),
              GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.gif_box_outlined,
                    color: Color(0xff4B9EEB),
                  )),
              addWidth(16),
              GestureDetector(
                  onTap: () {},
                  child: Transform.rotate(
                    angle: 7.88,
                    child: const Icon(
                      Icons.bar_chart_rounded,
                      color: Color(0xff4B9EEB),
                    ),
                  )),
              addWidth(16),
              GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xff4B9EEB),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close)),
            GestureDetector(
                onTap: () async {
                  if (_image != null) {
                    String imageData = await fileToBase64(_image!);
                    BlocProvider.of<TweetBloc>(context).tweet(
                      tweetModel: Tweetmodel(
                        name: 'Title',
                        id: Random().nextInt(1000),
                        tweet: _tweet.text,
                        image: imageData,
                        comments: Random().nextInt(1000),
                        likes: Random().nextInt(1000),
                        reply: Random().nextInt(1000),
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                    setState(() {});
                  } else {
                    if (_tweet.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Please Type your tweet');
                    } else {
                      Fluttertoast.showToast(msg: 'Please capture an image');
                    }
                  }
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff4B9EEB),
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                      child: Text(
                        'Post',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )))
          ],
        ),
      );
  _post() {}
  Widget textBox() => TextFormField(
        controller: _tweet,
        maxLines: 15,
        minLines: 2,
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(color: Color(0xff687684)),
            hintText: 'What\'s Happening?'),
      );

  Widget capturedImage() {
    return Center(
      child: FutureBuilder<void>(
          future: retrieveLostData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return showImage();
              case ConnectionState.done:
                return showImage();
              case ConnectionState.active:
                if (snapshot.hasError) {
                  return Text(
                    'Pick image/video error: ${snapshot.error}}',
                    textAlign: TextAlign.center,
                  );
                } else {
                  return showImage();
                }
            }
          }),
    );
  }

  Widget showImage() {
    return Stack(
      children: [
        SizedBox(
            child: _image != null
                ? Image.file(
                    _image!,
                    fit: BoxFit.cover,
                  )
                : const SizedBox.shrink()),
        _image != null
            ? Positioned(
                right: 12,
                top: 12,
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _image = null;
                      });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )))
            : const SizedBox.shrink(),
      ],
    );
  }

  Future<String> fileToBase64(File file) async {
    List<int> fileBytes = await file.readAsBytes();
    String base64String = base64Encode(fileBytes);
    return base64String;
  }
}
