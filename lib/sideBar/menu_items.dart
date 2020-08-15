import 'package:flutter/material.dart';
import 'package:modern_music/utils/icon_color.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;

  const MenuItem({Key key, this.icon, this.title, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconChanger iconChanger;
    iconChanger = Provider.of<IconChanger>(context);
    final _width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: iconChanger.getIcon(),
              size: 24,
            ),
            SizedBox(
              width: _width * 0.04,
            ),
            Text(
              title,
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
    );
  }
}
