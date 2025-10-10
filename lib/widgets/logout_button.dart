import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final connexionVM = Provider.of<ConnexionVM>(context, listen: false);

    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Déconnexion'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      onPressed: () async {
        await connexionVM.disconnect();
      },
    );
  }
}