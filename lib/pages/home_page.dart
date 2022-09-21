import 'package:flutter/material.dart';
import 'package:teste_tecnico/widgets/nav_drawer.dart';

class HomePage extends StatefulWidget{  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();  
}

class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) { 
    return
      Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
        ),
        body: const Center(child: Text('teste')),
    );
  }
}

