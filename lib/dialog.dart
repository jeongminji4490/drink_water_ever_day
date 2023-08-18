import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      backgroundColor: Colors.black,
      title: const Text(
        "Success",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'AmaticscBold', fontSize: 15, color: Colors.white),
      ),
      content: Image.asset(
        'assets/images/water_drop.gif',
        height: 100,
        width: 100,
      ),
      actions: <Widget>[
        TextButton(
          child: const Text(
            "Ok",
            style: TextStyle(
                fontFamily: 'AmaticscBold', fontSize: 15, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
