import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_project/cup_image.dart';
import 'package:my_flutter_project/database_helper.dart';
import 'package:my_flutter_project/stamp.dart';
import 'package:my_flutter_project/stamp_builder.dart';
import 'package:my_flutter_project/dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final DatabaseHelper dbHelper = DatabaseHelper();

  final String title = "Drink 8 Water";

  int cups = 0;

  Future<Stamp> getStamp(String date) async {
    return await dbHelper.getStamp(date);
  }

  Future<List<Stamp>> getAllStamps() async {
    return await dbHelper.getAllStamps();
  }

  Future<void> insertStamp(String date) async {
    await dbHelper
        .insert(Stamp(date: date, cups: cups));
  }
  
  Future<void> deleteStamp(String date) async {
    await dbHelper.delete(date);
  }

  void _drinkWater(String date) {
    setState(() {
      print("cups: $cups");
      if (cups < 8) {
        cups++;
      }
      if (cups == 8) {
        insertStamp(date);
        showDialog(context: context, builder: (_) =>
            const CustomDialog()
        );
      }
    });
  }

  void _myMistake() {
    setState(() {
      if (cups > 0) {
        cups--;
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
                height: 180,
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
                          fontFamily: 'AmaticscBold', fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    if (cups == 0)
                      const Expanded(
                        child: Text(
                          "You haven't even had a glass of water today!",
                          style: TextStyle(
                              fontFamily: 'AmaticscBold', fontSize: 10),
                          textAlign: TextAlign.center,
                        ),
                      )
                    else
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (int i = 0; i < cups; i++) const CupImage()
                          ],
                        ),
                      ),
                    Text(
                      "$cups/8",
                      style: const TextStyle(
                          fontFamily: 'AmaticscBold', fontSize: 23),
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
                        onPressed: () => {
                          if (cups != 8) {
                            _drinkWater(todayDate)
                          }
                          // insertStamp(todayDate)
                        },
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
                        onPressed: () => {
                          _myMistake(),
                          deleteStamp(todayDate)
                        },
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
              if (cups == 8) ...[
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return AlertDialog(
                //         title: Text(""),
                //         content: SingleChildScrollView(
                //           child: ListBody(
                //             children: <Widget>[
                //               Text("Test1"),
                //               Text("Test2")
                //             ],
                //           ),
                //         ),
                //       )
                //     })
                // const Icon(
                //   Icons.check_circle,
                //   color: Colors.black,
                //   size: 30.0,
                // ),
                // const Text(
                //   "Success",
                //   style: TextStyle(
                //       fontFamily: 'AmaticscBold',
                //       fontSize: 15,
                //       color: Colors.black),
                // ),
              ],
              StampBuilder(future: getAllStamps())
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
