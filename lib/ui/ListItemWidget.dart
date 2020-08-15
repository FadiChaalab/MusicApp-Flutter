import 'dart:io';
import 'package:flutter/material.dart';

typedef OnTap = void Function();

class ListItemWidget extends StatelessWidget {
  final String imagePath;
  final Widget title, subtitle;
  final Widget trailing;
  final OnTap onTap;

  ListItemWidget(
      {this.title, this.subtitle, this.imagePath, this.trailing, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 0.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: (imagePath == null)
                  ? AssetImage("assets/images/3.jpg")
                  : FileImage(File(imagePath)),
            ),
            onTap: onTap,
            title: title ?? Container(),
            subtitle: subtitle ?? Container(),
            trailing: trailing,
          ),
          SizedBox(
            height: 2,
          ),
        ],
      ),
    );
  }
}
