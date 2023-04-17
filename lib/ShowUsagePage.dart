import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ShowUsagePage extends StatefulWidget {
  final String amiiboTail;

  ShowUsagePage({required this.amiiboTail});

  @override
  _ShowUsagePageState createState() => _ShowUsagePageState();
}

class _ShowUsagePageState extends State<ShowUsagePage> {
  Map<String, dynamic>? amiiboData;

  @override
  void initState() {
    super.initState();
    fetchAmiiboData();
  }

  Future<void> fetchAmiiboData() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo/?showusage'));
    final jsonResponse = json.decode(response.body);
    final amiibos = jsonResponse['amiibo'] as List<dynamic>;
    final amiibo = amiibos.firstWhere((element) => element['tail'] == widget.amiiboTail);
    setState(() {
      amiiboData = amiibo;
    });
  }

  Widget consoleSection(String title, List<dynamic> games) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 8),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: games.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                title: Text(games[index]['gameName']),
                subtitle: Text(games[index]['amiiboUsage'][0]['Usage']),
              );
            },
          ),
          SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (amiiboData == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Amiibo Usage'),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Amiibo Usage'),
        ),
        body: ListView(
          children: [
            consoleSection('3DS Games', amiiboData!['games3DS']),
            consoleSection('Wii U Games', amiiboData!['gamesWiiU']),
            consoleSection('Switch Games', amiiboData!['gamesSwitch']),
          ],
        ),
      );
    }
  }
}
