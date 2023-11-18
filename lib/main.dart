// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'writing_screen.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MyHomePage(),
        '/writing': (context) => WritingScreen(),
      },
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 23, 43),
      body: SafeArea(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as is parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(43)),
                    color: Color.fromARGB(255, 48, 44, 61),
                  ),
                  padding: EdgeInsets.fromLTRB(37, 9, 37, 9),
                  child: Text(
                    "Summit",
                    style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        color: Colors.white,
                        fontSize: 24),
                  ),
                ),
                // SizedBox(
                //   height: 40,
                // ),
                Container(
                  child: const Text(
                    'Summarize any text or file in seconds',
                    style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        color: Colors.white,
                        fontSize: 30),
                  ),
                ),
                // SizedBox(
                //   height: 40,
                // ),
                Hero(
                  tag: 'Textbox',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/writing');
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: DefaultTextStyle(
                        style: TextStyle(
                            fontFamily: 'Space Grotesk',
                            color: Colors.white,
                            fontSize: 15),
                        child: Text(
                          "Type your text here...",
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Color.fromARGB(255, 51, 44, 74),
                      ),
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0),
                  child: Text(
                    'or',
                    style: TextStyle(
                        fontFamily: 'Space Grotesk',
                        color: Colors.white,
                        fontSize: 15),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf', 'docx'],
                    );

                    if (result != null) {
                      File file = File(result.files.single.path!);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/upload.svg', height: 40),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Upload a file",
                            style: TextStyle(
                                fontFamily: 'Space Grotesk',
                                color: Colors.white,
                                fontSize: 15),
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Text(
                            ".pdf and .docx files are supported",
                            style: TextStyle(
                              fontFamily: 'Space Grotesk',
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      color: Color.fromARGB(255, 51, 44, 74),
                    ),
                    width: MediaQuery.of(context).size.width * .7,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
