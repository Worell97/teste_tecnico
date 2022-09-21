import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_tecnico/widgets/drop_down.dart';

class RacesPage extends StatefulWidget{
  const RacesPage({super.key});

  @override
  State<RacesPage> createState() => _RacesPageState();
}

class _RacesPageState extends State<RacesPage>{
  late Future<Races> futureRaces;
  late String currentSelection = 'dwarf';

  

  @override
  void initState(){
    super.initState();
    attRaces();
  }

  void attRaces(){
    futureRaces = fetchRaces(currentSelection);
  }
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: FutureBuilder<Races>(
          future: futureRaces,
          builder: ((context, snapshot) {
            if(snapshot.hasData){
              return Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [                  
                  DropDown(
                    type: 'race',
                    variable: currentSelection, 
                    onChange: (newVal) {
                      setState(() {
                        currentSelection = newVal;
                      });
                      attRaces();
                    }
                  ),
                  Text(snapshot.data!.name),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(snapshot.data!.url),
                        ],
                      ),
                    ),  
                  ),
                ],
              );
            }else if(snapshot.hasError){
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          }),
        ), 
      ),
    );
  }
}


Future<Races> fetchRaces(race) async {
  final response = await
    http.get(Uri.parse('https://www.dnd5eapi.co/api/races/$race'));
  
  if(response.statusCode == 200){
    return Races.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load class');
  }
}

class Races {
  final String index;
  final String name;
  final String url;

  const Races({
    required this.index,
    required this.name,
    required this.url,
  });

  factory Races.fromJson(Map<String, dynamic> json){
    return Races(
      index: json['index'],
      name: json['name'],
      url: json['url']
    );
  }
}