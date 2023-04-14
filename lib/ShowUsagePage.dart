import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowUsagePage extends StatefulWidget {
  final String characterName;

  ShowUsagePage({required this.characterName});

  @override
  _ShowUsagePageState createState() => _ShowUsagePageState();
}

class _ShowUsagePageState extends State<ShowUsagePage> {
  bool _isLoading = true;
  String _resultMessage = '';
  Map<String, dynamic> _usageData = {};

  @override
  void initState() {
    super.initState();
    _fetchUsageData();
  }

  Future<void> _fetchUsageData() async {
    final response = await http.get(Uri.parse(
        'https://www.amiiboapi.com/api/amiibo/?character=${widget.characterName}&showusage'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _isLoading = false;
        _usageData = data['amiibo'][0];
      });
    } else {
      setState(() {
        _isLoading = false;
        _resultMessage = 'Error fetching usage data.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.characterName} Usage'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _usageData.isEmpty
          ? Center(child: Text(_resultMessage))
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Game 3DS:'),
              ...(_usageData['games3DS'] as List<dynamic>).map((game) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Game Name: ${game['gameName']}'),
                        Text('Game ID: ${game['gameID'].join(', ')}'),
                        Text('Amiibo Usage:'),
                        ...game['amiiboUsage']
                            .map<Widget>((usage) => Text(
                            '  Usage: ${usage['Usage']} (Write: ${usage['write']})'))
                            .toList(),
                      ],
                    ),
                  ),
                );
              }).toList(),
              // Add other game platforms (gameWiiU, gameSwitch) here in a similar manner
            ],
          ),
        ),
      ),
    );
  }
}
