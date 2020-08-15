import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/utils/bio.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/user.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Username username;
  UserBio userBio;
  TextEditingController text = new TextEditingController();
  bool err = false;
  ColorChanger colorChanger;

  @override
  Widget build(BuildContext context) {
    username = Provider.of<Username>(context);
    userBio = Provider.of<UserBio>(context);
    colorChanger = Provider.of<ColorChanger>(context);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        return null;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: _height,
            width: _width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorChanger.getAccent(),
                  colorChanger.getAccent(),
                  colorChanger.getAccent(),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * 0.052,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(FontAwesome.user_circle),
                        iconSize: 24,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.056,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Account Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1.1,
                          color: Colors.white,
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
                      IconButton(
                        icon: Icon(FontAwesome.edit),
                        iconSize: 24,
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      _displayDialog(context);
                    },
                    child: Container(
                      height: _height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue[500],
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesome.user_o,
                                  ),
                                  color: Colors.blue[900],
                                  iconSize: 24,
                                ),
                                SizedBox(
                                  width: _width * 0.01,
                                ),
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 2,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Change Your Name On This App',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: InkWell(
                    onTap: () {
                      _displayDialogBio(context);
                    },
                    child: Container(
                      height: _height * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue[500],
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 12.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesome.file_text_o,
                                  ),
                                  color: Colors.pink[900],
                                  iconSize: 24,
                                ),
                                SizedBox(
                                  width: _width * 0.01,
                                ),
                                Text(
                                  "Bio",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 1,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 2,
                            ),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Change Your Bio On This App',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: _height * 0.052,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              shape: Border.all(color: Colors.greenAccent),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Enter your name!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              content: TextFormField(
                maxLength: 12,
                controller: text,
                decoration: InputDecoration(
                    errorText: err ? "Whats in a name?" : null,
                    errorStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                    labelText: "Enter Name",
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'Set',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    validate(context);
                  },
                )
              ],
            ),
          );
        });
  }

  void validate(context) {
    setState(() {
      text.text.isEmpty ? err = true : err = false;
    });
    if (text.text.isNotEmpty) {
      username.setName(text.text.toString());
      text.clear();
      Navigator.of(context).pop();
    } else {}
  }

  //UserBio
  _displayDialogBio(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AlertDialog(
              shape: Border.all(color: Colors.greenAccent),
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text(
                'Enter your bio!',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
              content: TextFormField(
                maxLength: 45,
                controller: text,
                decoration: InputDecoration(
                    errorText: err ? "Whats in a bio?" : null,
                    errorStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                    labelText: "Enter Bio",
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text(
                    'Set',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    validateBio(context);
                  },
                )
              ],
            ),
          );
        });
  }

  void validateBio(context) {
    setState(() {
      text.text.isEmpty ? err = true : err = false;
    });
    if (text.text.isNotEmpty) {
      userBio.setBio(text.text.toString());
      text.clear();
      Navigator.of(context).pop();
    } else {}
  }
}
