import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:provider/provider.dart';

class CardItemWidget extends StatefulWidget {
  final double width, height;
  final String backgroundImage, title, infoS, subtitle, infoT, infoText;
  final int index;
  static const titleMaxLines = 1;
  static const titleTextStyle = TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 16.0,
    fontFamily: 'Poppins',
    color: Colors.white,
    shadows: [
      Shadow(
        blurRadius: 1,
        color: Colors.black,
      ),
    ],
  );

  CardItemWidget({
    this.width,
    this.height,
    this.backgroundImage,
    this.title = "Title",
    this.infoS,
    this.subtitle = "subtitle",
    this.infoT,
    this.infoText = "",
    this.index,
  });

  @override
  _CardItemWidgetState createState() => _CardItemWidgetState();
}

class _CardItemWidgetState extends State<CardItemWidget> {
  IconChanger iconChanger;
  @override
  Widget build(BuildContext context) {
    iconChanger = Provider.of<IconChanger>(context);
    final mainContainer = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: (widget.backgroundImage == null)
              ? AssetImage("assets/images/3.jpg")
              : FileImage(File(widget.backgroundImage)),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50.0)),
                child: IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: iconChanger.getIcon(),
                    size: 35,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text(
                      widget.title,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      maxLines: CardItemWidget.titleMaxLines,
                      style: CardItemWidget.titleTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.infoS,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            widget.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.infoT,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 1,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            widget.infoText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 1,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: mainContainer,
      ),
    );
  }
}

class DolDurmaClipper extends CustomClipper<Path> {
  DolDurmaClipper({@required this.right, @required this.holeRadius});

  final double right;
  final double holeRadius;

  @override
  Path getClip(Size size) {
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width - right - holeRadius, 52.0)
      ..arcToPoint(
        Offset(size.width - right, 60),
        clockwise: false,
        radius: Radius.circular(1),
      )
      ..lineTo(size.width, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width - right, size.height);

    path.lineTo(0.0, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(DolDurmaClipper oldClipper) => true;
}
