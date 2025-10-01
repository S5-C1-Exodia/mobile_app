import 'package:flutter/material.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: null, // Non fonctionnel
              child: Text('Se connecter à une autre API'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }
}
