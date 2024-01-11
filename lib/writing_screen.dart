import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WritingScreen extends StatelessWidget {
  WritingScreen({super.key});

  void _fetchData(BuildContext context, [bool mounted = true]) async {
    showDialog(
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
      final response = await http.post(
        Uri.parse("https://summit-backend.azurewebsites.net/text"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{"text": _textEditingController.text}),
      );

      if (response.statusCode == 200) {
        // Request was successful
        final data = json.decode(response.body);
        if (!mounted) return;
        Navigator.pushNamed(context, '/result', arguments: data["summary"]);
      } else {
        // Request failed
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // An error occurred
      print('Error: $error');
    }
  }

  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 23, 43),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 23, 43),
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () => _fetchData(context),
              icon: Icon(Icons.send),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Hero(
          tag: 'Textbox',
          child: Material(
            type: MaterialType.transparency,
            child: TextFormField(
              controller: _textEditingController,
              style: TextStyle(color: Colors.white),
              autofocus: true,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: "Type your text here...",
                border: InputBorder.none,
                hintStyle: TextStyle(
                    fontFamily: 'Space Grotesk',
                    color: Colors.white,
                    fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
