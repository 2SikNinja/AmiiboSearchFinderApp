import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AmiiboGridViewPage.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchAllAmiibos();
  }

  Future<void> _fetchAllAmiibos() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo/'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final amiiboList = jsonResponse['amiibo'];

      // Simulate progress (Since the API doesn't provide progress info)
      for (int i = 1; i <= 10; i++) {
        await Future.delayed(Duration(milliseconds: 100));
        setState(() {
          progressValue = i / 10;
        });
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AmiiboGridViewPage()),
      );
    } else {
      throw Exception('Failed to load amiibos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Downloading Data"),
            SizedBox(height: 20),
            SizedBox(
              height: 10,
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
