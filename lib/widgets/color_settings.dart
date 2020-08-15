import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:modern_music/utils/color.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:provider/provider.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {
  ColorChanger colorChanger;
  IconChanger iconChanger;
  @override
  Widget build(BuildContext context) {
    colorChanger = Provider.of<ColorChanger>(context);
    iconChanger = Provider.of<IconChanger>(context);
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
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                      IconButton(
                        icon: Icon(FontAwesome.paint_brush),
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
                        'Colors Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          color: Colors.white,
                          letterSpacing: 1.1,
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
                        icon: Icon(
                          FontAwesome.edit,
                          size: 24,
                        ),
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
                  padding: EdgeInsets.only(top: 80.0, left: _width * 0.02),
                  child: ListTile(
                    title: Text(
                      "Accent Color",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 1.1,
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
                    trailing: CircleColor(
                      color: colorChanger.getAccent(),
                      circleSize: 25.0,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _height * 0.14,
                              horizontal: _width * 0.15),
                          child: Container(
                            color: Theme.of(context).backgroundColor,
                            height: _height * 0.2,
                            width: _width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    height: _height * 0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialColorPicker(
                                        colors: [
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.green,
                                          Colors.pink,
                                          Colors.orange,
                                          Colors.teal,
                                          Colors.purpleAccent,
                                          Colors.pinkAccent,
                                          Colors.orangeAccent,
                                        ],
                                        allowShades: false,
                                        selectedColor: colorChanger.getAccent(),
                                        circleSize: 70,
                                        onMainColorChange:
                                            (ColorSwatch selectedColor) {
                                          colorChanger.setAccent(selectedColor);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: FloatingActionButton(
                                      child: Icon(FontAwesome.leaf),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: _height * 0.06,
                ),
                Padding(
                  padding: EdgeInsets.only(left: _width * 0.02),
                  child: ListTile(
                    title: Text(
                      "Icons Color",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.white,
                        letterSpacing: 1.1,
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
                    trailing: CircleColor(
                      color: iconChanger.getIcon(),
                      circleSize: 25.0,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _height * 0.14,
                              horizontal: _width * 0.15),
                          child: Container(
                            color: Theme.of(context).backgroundColor,
                            height: _height * 0.2,
                            width: _width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    height: _height * 0.42,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: MaterialColorPicker(
                                        colors: [
                                          Colors.cyan,
                                          Colors.indigo,
                                          Colors.blue,
                                          Colors.red,
                                          Colors.purple,
                                          Colors.green,
                                          Colors.pink,
                                          Colors.orange,
                                          Colors.teal,
                                          Colors.purpleAccent,
                                          Colors.pinkAccent,
                                          Colors.orangeAccent,
                                        ],
                                        allowShades: false,
                                        selectedColor: iconChanger.getIcon(),
                                        circleSize: 70,
                                        onMainColorChange:
                                            (ColorSwatch selectedColor) {
                                          iconChanger.setIcon(selectedColor);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: FloatingActionButton(
                                      child: Icon(FontAwesome.leaf),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
