import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'MyAmiiboList.dart';

class AmiiboGridViewPage extends StatefulWidget {
  @override
  _AmiiboGridViewPageState createState() => _AmiiboGridViewPageState();
}

class _AmiiboGridViewPageState extends State<AmiiboGridViewPage> {
  List<dynamic> amiibos = [];
  List<dynamic> favoriteAmiibos = [];

  @override
  void initState() {
    super.initState();
    _fetchAllAmiibos();
  }

  Future<void> _fetchAllAmiibos() async {
    final response = await http.get(
        Uri.parse('https://www.amiiboapi.com/api/amiibo/'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final amiiboList = jsonResponse['amiibo'];

      setState(() {
        amiibos =
            amiiboList.where((amiibo) => amiibo['type'] == 'Figure').toList();
      });
    } else {
      throw Exception('Failed to load amiibos');
    }
  }

  Future<void> _toggleFavorite(Map<String, dynamic> amiibo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteAmiiboIds = prefs.getStringList('favoriteAmiiboIds') ??
        [];

    if (favoriteAmiiboIds.contains(amiibo['tail'])) {
      favoriteAmiiboIds.remove(amiibo['tail']);
    } else {
      favoriteAmiiboIds.add(amiibo['tail']);
    }

    await prefs.setStringList('favoriteAmiiboIds', favoriteAmiiboIds);
    _updateFavoriteAmiibos();
  }

  Future<void> _updateFavoriteAmiibos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteAmiiboIds = prefs.getStringList('favoriteAmiiboIds') ??
        [];

    setState(() {
      favoriteAmiibos =
          amiibos.where((amiibo) => favoriteAmiiboIds.contains(amiibo['tail']))
              .toList();
    });
  }

  bool _isFavorite(String tail) {
    return favoriteAmiibos.any((amiibo) => amiibo['tail'] == tail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Amiibos'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    MyAmiiboList(favoriteAmiibos: favoriteAmiibos)),
              );
            },
          ),
        ],
      ),
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
                    Navigator.pushNamed(
                      context,
                      '/showusage',
                      arguments
                          : {'name': amiibo['name']},
                    );
                  },
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(
                              amiibo['image'], height: 150, width: 150),
                          IconButton(
                            icon: Icon(
                              _isFavorite(amiibo['tail'])
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: _isFavorite(amiibo['tail'])
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              _toggleFavorite(amiibo);
                            },
                          ),
                        ],
                      ),
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
                    Navigator.pushNamed(
                      context,
                      '/showusage',
                      arguments: {'name': amiibo['name']},
                    );
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