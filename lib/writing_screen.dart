import 'package:flutter/material.dart';

class WritingScreen extends StatelessWidget {
  const WritingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 23, 43),
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 28, 23, 43),
          foregroundColor: Colors.white,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.send))]),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Hero(
          tag: 'Textbox',
          child: Material(
            type: MaterialType.transparency,
            child: TextFormField(
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
