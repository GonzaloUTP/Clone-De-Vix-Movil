import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CharacterList(),
    );
  }
}

class CharacterList extends StatefulWidget {
  @override
  _CharacterListState createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _allCharacters = [];
  List<dynamic> _filteredCharacters = [];
  bool _isSearching = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
  }

  Future<void> _fetchCharacters() async {
    try {
      final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
      if (response.statusCode == 200) {
        setState(() {
          _allCharacters = json.decode(response.body)['results'];
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load characters')));
    }
  }

  void _filterCharacters(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCharacters = [];
        _isSearching = false;
      } else {
        _filteredCharacters = _allCharacters.where((character) {
          return character['name'].toLowerCase().contains(query.toLowerCase());
        }).toList();
        _isSearching = true;
      }
    });
  }

  void _showCharacterDetails(dynamic character) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(character['image']),
                SizedBox(height: 8),
                Text(
                  character['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text('Status: ${character['status']}', style: TextStyle(color: Colors.white)),
                Text('Species: ${character['species']}', style: TextStyle(color: Colors.white)),
                Text('Gender: ${character['gender']}', style: TextStyle(color: Colors.white)),
                Text('Origin: ${character['origin']['name']}', style: TextStyle(color: Colors.white)),
                Text('Location: ${character['location']['name']}', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.black,
            border: Border.all(color: Colors.white),
          ),
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Buscar personajes...',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search, color: Colors.white),
            ),
            onChanged: (query) {
              _filterCharacters(query);
            },
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _isSearching
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
                    childAspectRatio: 2 / 3,
                  ),
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final character = _filteredCharacters[index];
                    return GestureDetector(
                      onTap: () => _showCharacterDetails(character),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.black,
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(character['image']),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  character['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'Escribe algo en el buscador para comenzar la búsqueda.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
    );
  }
}
