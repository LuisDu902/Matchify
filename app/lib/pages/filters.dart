import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matchify/pages/appBar/infoScreen.dart';
import 'appBar/appBar.dart';
import 'song/swipe.dart';
import '../backend/variables.dart';

class Filters extends StatefulWidget {
  const Filters({Key? key});

  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  /*   darkmode   */
  late Color bgColor;
  late Color boxFilter;
  late Color singularFilter;
  late Color sizeColor;

  List<String> genres = [...iniGenres];
  List<String> decades = [...iniDecades];

  @override
  void initState() {
    super.initState();
    updateColors();
    chosenFilters.clear();
    playlistSize = 0;
  }

  void updateColors() {
    setState(() {
      bgColor = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(59, 59, 59, 1)
          : Colors.white;

      boxFilter = DarkMode.isDarkModeEnabled
          ? Colors.white
          : const Color.fromRGBO(151, 138, 168, 1);

      singularFilter = DarkMode.isDarkModeEnabled
          ? const Color.fromRGBO(224, 217, 228, 1)
          : const Color.fromRGBO(251, 237, 160, 1);

      sizeColor = DarkMode.isDarkModeEnabled
          ? Colors.white
          : const Color.fromRGBO(248, 206, 156, 1);
    });
  }

  bool _isGenreListVisible = false;
  bool _isDecadeListVisible = false;

  Widget drawIcon(String filter) {
    switch (filter) {
      case 'Genre':
        return Icon(
          key: Key(filter),
          _isGenreListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        );
      case 'Decade':
        return Icon(
          key: Key(filter),
          _isDecadeListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24.0,
        );
    }
    return const Text('(5-60)');
  }

  Widget drawButton(String filter) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(224, 217, 228, 1)),
          foregroundColor: MaterialStateProperty.all<Color>(
            const Color.fromRGBO(48, 21, 81, 1),
          ),
          fixedSize: MaterialStateProperty.resolveWith<Size?>(
              (states) => const Size(240, 50)),
          textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => const TextStyle(
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
                _isDecadeListVisible = false;
                break;
              case 'Decade':
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
        filters = genres;
        break;
      case 'Decade':
        filters = decades;
        break;
    }
    if (filters.isEmpty) return Container();
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(16.0, 0, 16, 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: boxFilter,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        children: filters
            .map(
              (genre) => GestureDetector(
            onTap: () {
              setState(() {
                filters.remove(genre);
                chosenFilters.add(genre);
              });
            },
            child: Container(
              key: Key(genre),
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: singularFilter,
              ),
              child: Text(
                genre,
                style: const TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  color: Color.fromRGBO(48, 21, 81, 1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }


  Widget selectSize() {
    return Container(
      width: 70,
      height: 50,
      margin: const EdgeInsets.only(left: 10, top: 20, right: 30, bottom: 20),
      decoration: BoxDecoration(
        color: sizeColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        key: const Key("playlist size"),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: 'size',
          border: InputBorder.none,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^(\d|[1-5]\d|60)$')),
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
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 22,
          color: Color.fromRGBO(48, 21, 81, 1),
        ),
      ),
    );
  }

  Widget drawFilters() {
    if (chosenFilters.isEmpty) return Container();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: chosenFilters
              .map(
                (genre) => Container(
                  key: Key(genre),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(248, 206, 156, 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        genre,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          color: Color.fromRGBO(48, 21, 81, 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            chosenFilters.remove(genre);
                            if (iniGenres.contains(genre)) {
                              if (genres.isEmpty) _isGenreListVisible = false;
                              genres.add(genre);
                            } else if (iniDecades.contains(genre)) {
                              if (decades.isEmpty) _isDecadeListVisible = false;
                              decades.add(genre);
                            }
                          });
                        },
                        child: const Icon(
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
      key: const Key("filters page"),
      drawer: const Info(),
      appBar: const appBar(),
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
              drawButton('Decade'),
              if (_isDecadeListVisible) drawItems('Decade'),
              drawFilters(),
            ],
          ),
        ),
      ),
      floatingActionButton: (chosenFilters.isNotEmpty && playlistSize >= 5)
          ? ElevatedButton(
              onPressed: () {
                disliked.clear;
                liked.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SwipePage()),
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(248, 206, 156, 1)),
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(48, 21, 81, 1)),
              ),
              child: const Text(
                key: Key("continue"),
                "Continue",
              ),
            )
          : null,
    );
  }
}
