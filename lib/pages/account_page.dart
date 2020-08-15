import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modern_music/bloc/bloc.dart';
import 'package:modern_music/utils/bio.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:modern_music/utils/image.dart';

import 'package:modern_music/utils/user.dart';
import 'package:modern_music/widgets/account_screen.dart';
import 'package:provider/provider.dart';

class MyAccountsPage extends StatefulWidget with NavigationStates {
  @override
  _MyAccountsPageState createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  Username username;
  UserBio userBio;
  String retrieveDataError;
  Image imageFromPreferences;
  Future<File> imageFile;
  ColorChanger colorChanger;
  IconChanger iconChanger;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  loadImageFromPreferences() {
    SaveImage.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = SaveImage.imageFromBase64String(img);
      });
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          SaveImage.saveImageToPreferences(
              SaveImage.base64String(snapshot.data.readAsBytesSync()));
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70),
              image: DecorationImage(
                image: FileImage(
                  snapshot.data,
                ),
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (null != snapshot.error) {
          return Container(
            height: 140,
            width: 140,
            child: imageFromPreferences == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      image: DecorationImage(
                        image: AssetImage('assets/images/user-default.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      image: DecorationImage(
                        image: imageFromPreferences.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          );
        } else {
          return Container(
            height: 140,
            width: 140,
            child: null == imageFromPreferences
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      image: DecorationImage(
                        image: AssetImage('assets/images/user-default.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      image: DecorationImage(
                        image: imageFromPreferences.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadImageFromPreferences();
  }

  @override
  Widget build(BuildContext context) {
    username = Provider.of<Username>(context);
    userBio = Provider.of<UserBio>(context);
    colorChanger = Provider.of<ColorChanger>(context);
    iconChanger = Provider.of<IconChanger>(context);
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        body: Container(
          width: _width,
          height: _height,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * 0.05,
              ),
              Container(
                height: _height * 0.1,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 50.0,
                        right: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Account',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              letterSpacing: 1.2,
                              fontFamily: 'Poppins',
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.black,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            FontAwesome.user_o,
                            color: iconChanger.getIcon(),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: _height * 0.05,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 0.0, 20.0, 0.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            border: Border.all(
                              color: iconChanger.getIcon(),
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: <Widget>[
                              imageFromGallery(),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 16,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    onPressed: () {
                                      pickImageFromGallery(ImageSource.gallery);
                                      setState(() {
                                        imageFromPreferences = null;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(12.0, 12.0, 0.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Text(
                                  'Username :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    color: iconChanger.getIcon(),
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                username.getName(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1.1,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 2,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 12.0,
                                left: 12,
                                right: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Bio :',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      letterSpacing: 1.1,
                                      fontFamily: 'Poppins',
                                      color: iconChanger.getIcon(),
                                      shadows: <Shadow>[
                                        Shadow(
                                          color: Colors.black,
                                          blurRadius: 2,
                                          offset: Offset(1, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                userBio.getBio(),
                                textAlign: TextAlign.start,
                                softWrap: true,
                                maxLines: 4,
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  letterSpacing: 1.1,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  shadows: <Shadow>[
                                    Shadow(
                                      color: Colors.black,
                                      blurRadius: 1,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 42, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Customize your account',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        color: iconChanger.getIcon(),
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountScreen(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                      iconSize: 24,
                      color: iconChanger.getIcon(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
