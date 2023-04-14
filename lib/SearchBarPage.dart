import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'CharacterDetailsPage.dart';

class SearchBarPage extends StatefulWidget {
  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  String _searchQuery = '';
  String _resultMessage = '';
  bool _isLoading = false;

  Future<void> _fetchData(String query) async {
    final response = await http.get(
        Uri.parse('https://www.amiiboapi.com/api/amiibo/?name=$query'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['amiibo'].isEmpty) {
        setState(() {
          _resultMessage = 'Character not found in the database.';
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailsPage(
              character: data['amiibo'][0],
            ),
          ),
        );
      }
    } else {
      setState(() {
        _resultMessage = 'Error fetching data.';
        _isLoading = false;
      });
    }
  }

  void _handleSearch(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar Page'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: _handleSearch,
              onSubmitted: (value) {
                setState(() {
                  _isLoading = true;
                  _resultMessage = '';
                });
                _fetchData(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Enter name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25.0),
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading) CircularProgressIndicator(),
          Text(_resultMessage),
        ],
      ),
    );
  }
}
