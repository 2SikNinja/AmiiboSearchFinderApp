import 'package:flutter/material.dart';

class MyAmiiboList extends StatelessWidget {
  final List<dynamic> favoriteAmiibos;
  final Function(String) favoriteStatusChanged;

  MyAmiiboList({
    required this.favoriteAmiibos,
    required this.favoriteStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Amiibos'),
      ),
      body: GridView.builder(
        itemCount: favoriteAmiibos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        padding: EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          final amiibo = favoriteAmiibos[index];
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
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.network(amiibo['image'], height: 150, width: 150),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              favoriteStatusChanged(amiibo['tail']);
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
