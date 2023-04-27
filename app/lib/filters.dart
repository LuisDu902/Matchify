import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/appBar/infoScreen.dart';
import 'appBar/appBar.dart';
import 'song/swipe.dart';
import 'constants.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key});

  @override
  _FiltersState createState() => _FiltersState();
}

List<String> _filters = [];

List<String> getFilters() {
  return _filters;
}

void clearFilters() {
  _filters.clear();
}

int playlistSize = 0;

class _FiltersState extends State<Filters> {
  //darkmode
  late Color bgColor;
  late Color boxFilter;
  late Color singularFilter;
  late Color sizeColor;

  @override
  void initState() {
    super.initState();
    updateColors();
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;

      boxFilter = DarkMode.isDarkModeEnabled
          ? //Color.fromRGBO(68, 47, 100, 1)
          Colors.white
          : Color.fromRGBO(151, 138, 168, 1);

      singularFilter = DarkMode.isDarkModeEnabled
          ? //Color.fromRGBO(179, 178, 174, 1)
          Color.fromRGBO(224, 217, 228, 1)
          : Color.fromRGBO(251, 237, 160, 1);

      sizeColor = DarkMode.isDarkModeEnabled
          ? // Color.fromRGBO(179, 178, 174, 1)
          Colors.white
          : Color.fromRGBO(248, 206, 156, 1);
    });
  }

//rest of code

  bool _isGenreListVisible = false;
  bool _isMoodListVisible = false;
  bool _isDecadeListVisible = false;
  List<String> getGenres() {
    return _genres;
  }

  List<String> _genres = [
    'Pop',
    'Funk',
    'Rock',
    'Heavy metal',
    'Classical',
    'Jazz',
    'Rap',
    'EDM'
  ];
  List<String> _decades = ['70\'s', '80\'s', '90\'s'];
  List<String> _moods = [
    'Happy',
    'Lonely',
    'Calm',
    'Sad',
    'Energetic',
  ];
  List<String> _iniGenres = [
    'Pop',
    'Funk',
    'Rock',
    'Heavy metal',
    'Classical',
    'Jazz',
    'Rap',
    'EDM'
  ];
  List<String> _iniDecades = ['70\'s', '80\'s', '90\'s'];
  List<String> _iniMoods = [
    'Happy',
    'Lonely',
    'Calm',
    'Sad',
    'Energetic',
  ];
  Widget drawIcon(String filter) {
    switch (filter) {
      case 'Genre':
        return Icon(
          key: Key(filter),
          _isGenreListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        );
      case 'Mood':
        return Icon(
          key: Key(filter),
          _isMoodListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        );
      case 'Decade':
        return Icon(
          key: Key(filter),
          _isDecadeListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        );
    }
    return Text('(5-60)');
  }

  Widget drawButton(String filter) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(224, 217, 228, 1)),
          foregroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(48, 21, 81, 1),
          ),
          fixedSize: MaterialStateProperty.resolveWith<Size?>(
              (states) => Size(240, 50)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => TextStyle(
                    fontSize: 22,
                    fontFamily: 'Roboto',
                    letterSpacing: 0.10000000149011612,
                  )),
        ),
        onPressed: () {
          setState(() {
            switch (filter) {
              case 'Genre':
                _isGenreListVisible = !_isGenreListVisible;
                _isMoodListVisible = false;
                _isDecadeListVisible = false;
                break;
              case 'Mood':
                _isMoodListVisible = !_isMoodListVisible;
                _isGenreListVisible = false;
                _isDecadeListVisible = false;
                break;
              case 'Decade':
                _isMoodListVisible = false;
                _isGenreListVisible = false;
                _isDecadeListVisible = !_isDecadeListVisible;
                break;
            }
          });
        },
        child: Row(
          children: [
            Expanded(
              child: Text(
                filter,
              ),
            ),
            drawIcon(filter),
          ],
        ),
      ),
    );
  }

  Widget drawItems(String filter) {
    List<String> filters = [];
    switch (filter) {
      case 'Genre':
        filters = _genres;
        break;
      case 'Mood':
        filters = _moods;
        break;
      case 'Decade':
        filters = _decades;
        break;
    }
    if (filters.isEmpty) return Container();
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(16.0, 0, 16, 10),
      padding: EdgeInsets.all(16.0), // add padding here
      decoration: BoxDecoration(
        color: boxFilter,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        runSpacing: 10.0,
        children: filters
            .map((genre) => GestureDetector(
                  onTap: () {
                    setState(() {
                      filters.remove(genre);
                      _filters.add(genre);
                    });
                  },
                  child: Container(
                    key: Key(genre),
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: singularFilter,
                    ),
                    child: Text(genre,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(48, 21, 81, 1),
                        )),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget selectSize() {
    return Container(
      width: 70,
      height: 50,
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: sizeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'size',
          border: InputBorder.none,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^([0-9]|[1-5][0-9]|60)$')),
        ],
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter an integer';
          }
          int? intValue = int.tryParse(value);
          if (intValue == null || intValue < 5 || intValue > 60) {
            return 'Please enter an integer between 5 and 60';
          }
          return null;
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            setState(() {
              playlistSize = int.parse(value);
            });
          }
        },
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22,
          color: Color.fromRGBO(48, 21, 81, 1),
        ),
      ),
    );
  }

  Widget drawFilters() {
    if (_filters.isEmpty) return Container();
    return Container(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _filters
              .map(
                (genre) => Container(
                  key: Key(genre),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(248, 206, 156, 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        genre,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(48, 21, 81, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _filters.remove(genre);
                            if (_iniGenres.contains(genre)) {
                              if (_genres.isEmpty) _isGenreListVisible = false;
                              _genres.add(genre);
                            } else if (_iniMoods.contains(genre)) {
                              if (_moods.isEmpty) _isMoodListVisible = false;
                              _moods.add(genre);
                            } else if (_iniDecades.contains(genre)) {
                              if (_decades.isEmpty)
                                _isDecadeListVisible = false;
                              _decades.add(genre);
                            }
                          });
                        },
                        child: Icon(
                          color: Color.fromRGBO(48, 21, 81, 1),
                          Icons.cancel_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key("filters page"),
      drawer: Info(),
      appBar: appBar(),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [drawButton('Playlist size'), selectSize()],
              ),
              drawButton('Genre'),
              if (_isGenreListVisible) drawItems('Genre'),
              drawButton('Mood'),
              if (_isMoodListVisible) drawItems('Mood'),
              drawButton('Decade'),
              if (_isDecadeListVisible) drawItems('Decade'),
              drawFilters(),
            ],
          ),
        ),
      ),
      floatingActionButton:( _filters.isNotEmpty && playlistSize >=5)
          ? ElevatedButton(
              onPressed: () {
                clearDislikedSongs();
                clearLikedSongs();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SwipePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(248, 206, 156, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(48, 21, 81, 1)),
              ),
              child: Text(
                key: Key("continue"),
                "Continue",
              ),
            )
          : null,
    );
  }
}
