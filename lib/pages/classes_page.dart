import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_tecnico/widgets/drop_down.dart';

class ClassPage extends StatefulWidget{
  const ClassPage({super.key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage>{
  late Future<Atribute> futureAtribute;
  late String currentSelection = 'barbarian';

  

  @override
  void initState(){
    super.initState();
    attAtribute();
  }

  void attAtribute(){
    futureAtribute = fetchAtribute(currentSelection);
  }
  
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: FutureBuilder<Atribute>(
          future: futureAtribute,
          builder: ((context, snapshot) {
            if(snapshot.hasData){
              return Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [                
                  DropDown(
                    variable: currentSelection, 
                    type: 'class',
                    onChange: (newVal) {
                      setState(() {
                        currentSelection = newVal;
                      });
                      attAtribute();
                    }
                  ),
                  Text(snapshot.data!.name),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(snapshot.data!.hitDie),
                        ],
                      ),
                    ), 
                  ), 
                ],);
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


Future<Atribute> fetchAtribute(atribute) async {
  final response = await
    http.get(Uri.parse('https://www.dnd5eapi.co/api/classes/$atribute'));
  
  if(response.statusCode == 200){
    return Atribute.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load class');
  }
}

class Atribute {
  final String index;
  final String name;
  final String hitDie;

  const Atribute({
    required this.index,
    required this.name,
    required this.hitDie,
  });

  factory Atribute.fromJson(Map<String, dynamic> json){
    return Atribute(
      index: json['index'],
      name: json['name'],
      hitDie: json['hit_die'].toString()
    );
  }
}