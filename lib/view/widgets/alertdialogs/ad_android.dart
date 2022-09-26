import 'package:band_names/viewmodels/bands/bands_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/bands/band_model.dart';

class AlertDialogAndroid extends StatelessWidget {
  const AlertDialogAndroid({
    Key? key,
    required this.bands,
  }) : super(key: key);

  final List<Band> bands;

  @override
  Widget build(BuildContext context) {
    final bandsViewModel = Provider.of<BandsViemodel>(context);
    final textController = TextEditingController();
    return AlertDialog(
      title: const Text('New Band Name'),
      content: TextField(
        controller: textController,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            bandsViewModel.addBandToList(context, textController.text);
            Navigator.pop(context);
          },
          elevation: 5,
          textColor: Colors.blue,
          child: const Text('Add'),
        )
      ],
    );
  }
}
