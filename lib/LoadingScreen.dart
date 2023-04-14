import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'AmiiboGridViewPage.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
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
        child: CircularProgressIndicator(),
      ),
    );
  }
}
