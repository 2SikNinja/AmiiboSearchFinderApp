import 'package:flutter/material.dart';
import 'ShowUsagePage.dart'; // Import the ShowUsagePage

class CharacterDetailsPage extends StatefulWidget {
  final Map<String, dynamic> character;

  CharacterDetailsPage({required this.character});

  @override
  _CharacterDetailsPageState createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.character['name']),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(widget.character['image']),
              // Add the Show Usage button below the image
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowUsagePage(
                        characterName: widget.character['character'],
                      ),
                    ),
                  );
                },
                child: Text('Show Usage'),
              ),
              SizedBox(height: 16),
              Text('Amiibo Series: ${widget.character['amiiboSeries']}'),
              Text('Character: ${widget.character['character']}'),
              Text('Game Series: ${widget.character['gameSeries']}'),
              Text('Head: ${widget.character['head']}'),
              Text('Tail: ${widget.character['tail']}'),
              Text('Type: ${widget.character['type']}'),
              Text('Release:'),
              Text('  AU: ${widget.character['release']['au']}'),
              Text('  EU: ${widget.character['release']['eu']}'),
              Text('  JP: ${widget.character['release']['jp']}'),
              Text('  NA: ${widget.character['release']['na']}'),
            ],
          ),
        ),
      ),
    );
  }
}
