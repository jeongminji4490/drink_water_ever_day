import 'package:flutter/material.dart';
import 'package:my_flutter_project/stamp.dart';

class StampBuilder extends StatelessWidget {
  const StampBuilder({super.key, required this.future});

  final Future<List<Stamp>> future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Stamp>>(
        future: future,
        builder: (context, snapshot) {
          var data = snapshot.data;
          if (data == null) {
            return const Text("No stamps",
                style: TextStyle(fontSize: 10, fontFamily: 'AmaticscBold'));
          } else {
            var length = data.length;
            if (length == 0) {
              return const Text("No stamps",
                  style: TextStyle(fontSize: 10, fontFamily: 'AmaticscBold'));
            } else {
              return Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final stamp = data[index];
                    return _buildStampCard(stamp, context);
                  },
                ),
              ));
            }
          }
        });
  }

  Widget _buildStampCard(Stamp stamp, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          stamp.date,
          style: const TextStyle(fontFamily: 'AmaticscBold', fontSize: 10),
        ),
      ),
    );
  }
}
