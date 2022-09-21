import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_tecnico/widgets/drop_down.dart';

class AtributePage extends StatefulWidget{
  const AtributePage({super.key});

  @override
  State<AtributePage> createState() => _AtributePageState();
}

class _AtributePageState extends State<AtributePage>{
  late Future<Atribute> futureAtribute;
  late String currentSelection = 'cha';

  

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
                    type: 'atribute',
                    variable: currentSelection, 
                    onChange: (newVal) {
                      setState(() {
                        currentSelection = newVal;
                      });
                      attAtribute();
                    }
                  ),
                  Text(snapshot.data!.fullName),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.description.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Text(snapshot.data!.description[index]),
                              ],
                            ),
                          ),  
                        );
                      },
                    ) 
                  )
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


Future<Atribute> fetchAtribute(atribute) async {
  final response = await
    http.get(Uri.parse('https://www.dnd5eapi.co/api/ability-scores/$atribute'));
  
  if(response.statusCode == 200){
    return Atribute.fromJson(jsonDecode(response.body));
  }else{
    throw Exception('Failed to load class');
  }
}

class Atribute {
  final String name;
  final String fullName;
  final List<dynamic> description;

  const Atribute({
    required this.name,
    required this.fullName,
    required this.description,
  });

  factory Atribute.fromJson(Map<String, dynamic> json){
    return Atribute(
      name: json['name'],
      fullName: json['full_name'],
      description: json['desc']
    );
  }
}