import 'package:flutter/material.dart';
import 'package:teste_tecnico/pages/atribute_page.dart';
import 'package:teste_tecnico/pages/classes_page.dart';
import 'package:teste_tecnico/pages/home_page.dart';
import 'package:teste_tecnico/pages/races_page.dart';

class NavDrawer extends StatelessWidget{
  const NavDrawer({super.key});


  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('lib/assets/starterset.jpg')
              )
            ),
            child: Text(
              'Side Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            title: const Text('Welcome'),
            onTap: () => {Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            )}
          ),
          ListTile(
            title: const Text('Classes'),
            onTap: () => {Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ClassPage(),
              ),
            )}
          ),
          ListTile(
            title: const Text('Atributes'),
            onTap: () => {Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AtributePage(),
              ),
            )}
          ),
          ListTile(
            title: const Text('Races'),
            onTap: () => {Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const RacesPage(),
              ),
            )}
          ),
          
        ],
      ),
    );
  }
}