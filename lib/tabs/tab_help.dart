import 'package:flutter/material.dart';

class HelpDialog extends StatefulWidget {
  const HelpDialog({super.key});

  @override
  State<HelpDialog> createState() => _HelpDialogState();
}

class _HelpDialogState extends State<HelpDialog> {
  List<String> sharedNumber = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmer la suppression'),
      content: const Text('Voulez vous vraiment supprimer cette entrée ?'),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red)),
          child: const Text(
            'Annuler',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(child: const Text('Supprimer'), onPressed: () {}),
      ],
    );
  }
}
