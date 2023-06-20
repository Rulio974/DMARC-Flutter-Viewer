import 'package:dmarc_flutter/config/const_var.dart';
import 'package:flutter/material.dart';

class ParamDialog extends StatefulWidget {
  const ParamDialog({super.key});

  @override
  State<ParamDialog> createState() => _ParamDialogState();
}

class _ParamDialogState extends State<ParamDialog> {
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
          child: Text(
            'Annuler',
            style: TextStyle(color: Theme.of(context).primaryTextColor),
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
