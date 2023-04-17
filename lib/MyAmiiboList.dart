import 'package:flutter/material.dart';
import 'package:amiibosearchfinder/ShowUsagePage.dart';

class MyAmiiboList extends StatefulWidget {
  final List<dynamic> favoriteAmiibos;
  final Function(String) favoriteStatusChanged;

  MyAmiiboList({
    required this.favoriteAmiibos,
    required this.favoriteStatusChanged,
  });

  @override
  _MyAmiiboListState createState() => _MyAmiiboListState();
}

class _MyAmiiboListState extends State<MyAmiiboList> {
  List<ValueNotifier<bool>> favoriteNotifiers = [];

  @override
  void initState() {
    super.initState();
    favoriteNotifiers = List<ValueNotifier<bool>>.generate(
        widget.favoriteAmiibos.length, (index) => ValueNotifier(true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Amiibos'),
      ),
      body: GridView.builder(
        itemCount: widget.favoriteAmiibos.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
        padding: EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          final amiibo = widget.favoriteAmiibos[index];
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
                          ValueListenableBuilder<bool>(
                            valueListenable: favoriteNotifiers[index],
                            builder: (context, value, child) {
                              return IconButton(
                                icon: Icon(
                                  value ? Icons.favorite : Icons.favorite_border,
                                  color: value ? Colors.red : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    favoriteNotifiers[index].value = !value;
                                    widget.favoriteStatusChanged(amiibo['tail']);
                                  });
                                },
                              );
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
