import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'MyAmiiboList.dart';
import 'package:amiibosearchfinder/ShowUsagePage.dart';

class AmiiboGridViewPage extends StatefulWidget {
  @override
  _AmiiboGridViewPageState createState() => _AmiiboGridViewPageState();
}

class _AmiiboGridViewPageState extends State<AmiiboGridViewPage> {
  List<dynamic> amiibos = [];
  List<dynamic> favoriteAmiibos = [];
  List<dynamic> filteredAmiibos = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchAllAmiibos();
    _searchController.addListener(_filterAmiibos);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchAllAmiibos() async {
    final response = await http.get(
        Uri.parse('https://www.amiiboapi.com/api/amiibo/?type=figure'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final amiiboList = jsonResponse['amiibo'];

      setState(() {
        amiibos =
            amiiboList.where((amiibo) => amiibo['type'] == 'Figure').toList();
        filteredAmiibos = List.from(amiibos);
      });
    } else {
      throw Exception('Failed to load amiibos');
    }
  }

  void _filterAmiibos() {
    setState(() {
      filteredAmiibos = amiibos
          .where((amiibo) =>
              amiibo['name']
                  .toLowerCase()
                  .contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  Future<void> _toggleFavoriteById(String tail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteAmiiboIds = prefs.getStringList('favoriteAmiiboIds') ??
        [];

    if (favoriteAmiiboIds.contains(tail)) {
      favoriteAmiiboIds.remove(tail);
    } else {
      favoriteAmiiboIds.add(tail);
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
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search Amiibo',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyAmiiboList(
                                        favoriteAmiibos: favoriteAmiibos,
                    favoriteStatusChanged: (String tail) {
                      _toggleFavoriteById(tail);
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: filteredAmiibos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        padding: EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          final amiibo = filteredAmiibos[index];
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowUsagePage(
                          amiiboTail: amiibo['tail'],
                        ),
                      ),
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
                              _toggleFavoriteById(amiibo['tail']);
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowUsagePage(
                          amiiboTail: amiibo['tail'],
                        ),
                      ),
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

