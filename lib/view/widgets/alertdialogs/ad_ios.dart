import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../models/bands/band_model.dart';
import '../../../viewmodels/bands/bands_viewmodel.dart';

class AlertDialogIos extends StatelessWidget {
  const AlertDialogIos({Key? key,required this.bands,}) : super(key: key);

  final List<Band> bands;

  @override
  Widget build(BuildContext context) {
    final bandsViewModel = Provider.of<BandsViemodel>(context);
    final textController = TextEditingController();
    return CupertinoAlertDialog(
      title: const Text('New Band Name'),
      content: CupertinoTextField(
        controller: textController,
      ),
      actions: [
        CupertinoDialogAction(
            onPressed: () {
              bandsViewModel.addBandToList(context, textController.text);
            },
            isDefaultAction: true,
            child: const Text('Add')),
        CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            isDestructiveAction: true,
            child: const Text('Dismiss')),
      ],
    );
  }
}