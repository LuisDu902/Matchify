import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';
import 'infoScreen.dart';
import 'swipe.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key});

  @override
  _FiltersState createState() => _FiltersState();
}

List<String> filters = [];

class _FiltersState extends State<Filters> {
  String? _selectedMood;
  String? _selectedDecade;
  String? _selectedGenre;
  bool _allCategoriesSelected = false;
 

  @override
  Widget build(BuildContext context) {
    _allCategoriesSelected = _selectedGenre != null && _selectedDecade != null && _selectedMood != null;
    return Scaffold(
      drawer: Info(),
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          child: const Text(
            'Matchify',
            style: TextStyle(
              color: Color.fromRGBO(48, 21, 81, 1),
              fontFamily: 'Italiana',
              fontSize: 30,
              letterSpacing: 0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const ImageIcon(
              AssetImage('images/settings.png'),
              color: Colors.black,
              size: 100,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const ImageIcon(
              AssetImage('images/user.png'),
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Playlist Size (5-60):',
            style: TextStyle(fontSize: 16),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter number',
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Mood:',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Happy'),
                  value: 'Happy',
                  groupValue: _selectedMood,
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Sad'),
                  value: 'Sad',
                  groupValue: _selectedMood,
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Energetic'),
                  value: 'Energetic',
                  groupValue: _selectedMood,
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Lonely'),
                  value: 'Lonely',
                  groupValue: _selectedMood,
                  onChanged: (value) {
                    setState(() {
                      _selectedMood = value as String?;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Decade:',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('1970'),
                  value: '1970',
                  groupValue: _selectedDecade,
                  onChanged: (value) {
                    setState(() {
                      _selectedDecade = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('1980'),
                  value: '1980',
                  groupValue: _selectedDecade,
                  onChanged: (value) {
                    setState(() {
                      _selectedDecade = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('1990'),
                  value: '1990',
                  groupValue: _selectedDecade,
                  onChanged: (value) {
                    setState(() {
                      _selectedDecade = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('2000'),
                  value: '2000',
                  groupValue: _selectedDecade,
                  onChanged: (value) {
                    setState(() {
                      _selectedDecade = value as String?;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Genre:',
            style: TextStyle(fontSize: 16),
          ),
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Heavy Metal'),
                  value: 'Heavy Metal',
                  groupValue: _selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Funk'),
                  value: 'Funk',
                  groupValue: _selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Pop'),
                  value: 'Pop',
                  groupValue: _selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value as String?;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Rock'),
                  value: 'Rock',
                  groupValue: _selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      _selectedGenre = value as String?;
                    });
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Mood: ${_selectedMood ?? ""}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Selected Decade: ${_selectedDecade ?? ""}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Selected Decade: ${_selectedGenre ?? ""}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
      
      floatingActionButton: _allCategoriesSelected ?
      ElevatedButton(
            onPressed: () {
              filters = [_selectedDecade!, _selectedGenre!, _selectedMood!];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SwipePage()),
              );
            },
            child: Text('Continue'),
          ): null,
    );
    ;
  }
}
