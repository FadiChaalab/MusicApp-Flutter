import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modern_music/bloc/bloc.dart';

class AboutPage extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Container(
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
                        'About',
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
                        Icons.verified_user,
                        color: Colors.deepPurple,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 20, 0),
                  child: Container(
                    height: _height * 0.36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue[900],
                          Colors.blue[700],
                          Colors.blue[500],
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 80,
                                width: 80,
                                child: CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/about2.jpg',
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Fadi Chaalab',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
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
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 48, top: 12),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Developer & Designer",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  FontAwesome.facebook_square,
                                  color: Color(0xFF2620A0),
                                  size: 24,
                                ),
                                onPressed: () {},
                                splashColor: Colors.grey,
                              ),
                              IconButton(
                                icon: Icon(
                                  FontAwesome.github,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onPressed: () {},
                                splashColor: Colors.grey,
                              ),
                              IconButton(
                                icon: Icon(
                                  FontAwesome.linkedin_square,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                onPressed: () {},
                                splashColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30.0, 0, 20, 0),
                  child: Container(
                    height: _height * 0.38,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple[900],
                          Colors.purple[700],
                          Colors.purple[500],
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 12,
                          ),
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Description :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    letterSpacing: 1.1,
                                    fontFamily: 'Poppins',
                                    color: Colors.pink,
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.black,
                                        blurRadius: 2,
                                        offset: Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Text(
                                  "An awesome music application created By Fadi Chaalab using Flutter.",
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
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
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      FontAwesome.phone,
                                      color: Colors.pink,
                                      size: 24,
                                    ),
                                    onPressed: () {},
                                    splashColor: Colors.grey,
                                  ),
                                  Text(
                                    '+21696338898',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: Colors.white.withOpacity(0.7),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      FontAwesome.envelope,
                                      color: Colors.pink,
                                      size: 24,
                                    ),
                                    onPressed: () {},
                                    splashColor: Colors.grey,
                                  ),
                                  Text(
                                    'chaalabfadi@gmail.com',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      fontFamily: 'Poppins',
                                      color: Colors.white.withOpacity(0.7),
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
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
