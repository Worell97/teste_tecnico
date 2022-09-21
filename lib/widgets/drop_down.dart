import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DropDown extends StatefulWidget{  
  String? variable;
  String? type;
  final onChange;
  DropDown({super.key, this.variable, this.type, this.onChange});
  
  @override
  State<DropDown> createState() => _DropDownState();  
}

class _DropDownState extends State<DropDown>{
  var data;
  late List atributes;
  String dropDownValue = '';


  @override
  void initState(){
    super.initState();
    asyncInitState();
    fetchAtributes();
  }  

  void asyncInitState() async {
    await fetchAtributes();
  }

  getUrlFromType(type){
    String baseurl = 'https://www.dnd5eapi.co/api/';
    String url = '';
    switch (type) {
      case 'class':
        url = 'classes/'; 
        break;     
      case 'atribute':  
        url = 'ability-scores/';
        break;
      case 'race':  
        url = 'races/';
        break;
      default:
    }
    return '$baseurl$url';
  }

  Future<void> fetchAtributes() async {
    await http.get(Uri.parse(getUrlFromType(widget.type))).then((response){
      if(response.statusCode == 200){
        setState(() {
          data = jsonDecode(response.body)?['results'];
          dropDownValue = data.first['index'] ?? '';
        });      
      }else{
        throw Exception('Failed to load classes');
      }
    });
  } 


  
  @override
  Widget build(BuildContext context){
    return
      SizedBox(
        height: 55,
        width: 300,
        child:
        ListView(
          children:[
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
              ),
              value: widget.variable,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              onChanged: (String? value){
                widget.onChange(value);
              },
              items: data?.map<DropdownMenuItem<String>>((item) {
                  return DropdownMenuItem<String>(
                    value: item['index'],
                    child: Text(item['name']!),
                  );
                }).toList(),                
            ),
          ] 
        ),
      );    
  }
}