import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_project/cup_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String title = "Drink 8 Water";
  int _cards = 0;

  void _drinkWater() {
    setState(() {
      if (_cards != 8) {
        _cards++;
      }
    });
  }

  void _myMistake() {
    setState(() {
      if (_cards != 0) {
        _cards--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = formatDate(DateTime.now(), 'yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontFamily: 'AmaticscBold')),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      todayDate,
                      style: const TextStyle(
                          fontFamily: 'AmaticscBold', fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    if (_cards == 0)
                      const Expanded(
                        child: Text(
                          "You haven't even had a glass of water today!",
                          style: TextStyle(
                              fontFamily: 'AmaticscBold', fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < _cards; i++) const CupImage()
                          ],
                        ),
                      ),
                    Text(
                      "$_cards/8",
                      style:
                          TextStyle(fontFamily: 'AmaticscBold', fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _drinkWater,
                        icon: const Icon(Icons.add, color: Colors.black),
                        label: const Text(
                          "Add",
                          style: TextStyle(
                              fontFamily: 'AmaticscBold',
                              fontSize: 15,
                              color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          side:
                              const BorderSide(width: 2.0, color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _myMistake,
                        icon: const Icon(Icons.delete, color: Colors.white),
                        label: const Text(
                          "Delete",
                          style: TextStyle(
                              fontFamily: 'AmaticscBold',
                              fontSize: 15,
                              color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(DateTime date, String format) {
    return DateFormat(format).format(date);
  }
}
