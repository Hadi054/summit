// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'writing_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => MyHomePage(),
        '/writing': (context) => WritingScreen(),
        '/result': (context) => ResultScreen()
      },
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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

  void _sendDocument(BuildContext context, {path}) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Color.fromARGB(255, 28, 23, 43),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Loading...",
                  style: TextStyle(color: Colors.white),
                ),
              ]),
            ),
          );
        });
    try {
      var headersList = {
        'Accept': '/',
        'User-Agent': 'Thunder Client (https://www.thunderclient.com)'
      };
      var url = Uri.parse('https://summit-backend.azurewebsites.net/upload');

      Map<String, String> body = {};

      var req = http.MultipartRequest('POST', url);
      req.headers.addAll(headersList);
      req.files.add(await http.MultipartFile.fromPath('file', path));
      // Map<String, String> stringFields =
      //     body.map((key, value) => MapEntry(key, value.toString()));

      // req.fields.addAll(stringFields);
      // req.fields.addAll(body);

      var res = await req.send();
      print('res');

      print(res);

      final resBody = await res.stream.bytesToString();
      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(resBody);
        final data = json.decode(resBody);
        if (mounted) {
          Navigator.pop(context);
          Navigator.pushNamed(context, '/result', arguments: data['summary']);
        }
      } else {
        print(res.reasonPhrase);
      }
    } catch (error) {
      // An error occurred
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 28, 23, 43),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
            child: Column(
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
                      allowedExtensions: ['pdf', 'docx', 'txt'],
                    );

                    if (result != null) {
                      print(result);
                      File file = File(result.files.single.path!);
                      print(file);
                      _sendDocument(context, path: file.path);
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
