import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainPage(
          title: "Daily Water",
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.title);

  final String title;
  final String subTitle =  "Today's goal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget> [
              Container(
                width: double.infinity,
                height: 200,
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color: Colors.black,
                      width: 2
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      subTitle,
                      style: const TextStyle(
                        fontFamily: 'AmaticscBold',
                        fontSize: 23
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/cup.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.asset(
                          'assets/images/cup.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.asset(
                          'assets/images/empty_cup.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        ),
                        Image.asset(
                          'assets/images/empty_cup.png',
                          width: 50,
                          height: 50,
                          fit: BoxFit.fitWidth,
                        )
                      ],
                    ),
                    Text(
                      "2/4",
                      style: TextStyle(
                          fontFamily: 'AmaticscBold',
                          fontSize: 23
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
