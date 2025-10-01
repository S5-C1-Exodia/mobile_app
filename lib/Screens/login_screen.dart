import 'package:flutter/material.dart';
import '../core/theme/palettes.dart';
import 'playlist_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => PlaylistsScreen(palette: paletteDark, onToggleTheme: () {})
            ));
          },
          child: Container(
            width: 120,
            height: 60,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              'Se connecter',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}