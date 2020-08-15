import 'package:flutter/material.dart';

class ChooseDialog extends StatefulWidget {
  final String title;
  final List<String> options;
  final _callback;
  final int indexSelected;

  ChooseDialog(
      {String title,
      List<String> options,
      void onChange(int index),
      int initialSelectedIndex})
      : title = title,
        options = options,
        indexSelected = initialSelectedIndex,
        _callback = onChange;

  @override
  _ChooseDialogState createState() => _ChooseDialogState();
}

class _ChooseDialogState extends State<ChooseDialog> {
  int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.indexSelected;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.options.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                        title: Text(
                          widget.options[index],
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: index,
                        groupValue: selectedIndex,
                        onChanged: (value) {
                          setState(() {
                            selectedIndex = value;
                          });

                          if (widget._callback != null)
                            widget._callback(selectedIndex);
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
