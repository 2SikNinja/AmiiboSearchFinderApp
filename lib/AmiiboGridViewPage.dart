import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AmiiboGridViewPage extends StatefulWidget {
  @override
  _AmiiboGridViewPageState createState() => _AmiiboGridViewPageState();
}

class _AmiiboGridViewPageState extends State<AmiiboGridViewPage> {
  List<dynamic> amiibos = [];

  @override
  void initState() {
    super.initState();
    _fetchAllAmiibos();
  }

  Future<void> _fetchAllAmiibos() async {
    final response = await http.get(Uri.parse('https://www.amiiboapi.com/api/amiibo/'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final amiiboList = jsonResponse['amiibo'];

      setState(() {
        amiibos = amiiboList.where((amiibo) => amiibo['type'] == 'Figure').toList();
      });
    } else {
      throw Exception('Failed to load amiibos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amiibo Grid View')),
      body: GridView.builder(
        itemCount: amiibos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        padding: EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          final amiibo = amiibos[index];
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/showusage', arguments: {'name': amiibo['name']});
                  },
                  child: Column(
                    children: [
                      Image.network(amiibo['image'], height: 150, width: 150),
                      SizedBox(height: 8),
                      Text(
                        amiibo['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/showusage', arguments: {'name': amiibo['name']});
                  },
                  child: Text('Show Usage'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
