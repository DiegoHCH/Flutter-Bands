import 'package:flutter/material.dart';

import '../../models/bands/band_model.dart';

class BandsViemodel extends ChangeNotifier {
  List<Band> bands = [
    Band(id: '1', name: 'Imagine Dragons', votes: 5),
    Band(id: '2', name: 'Morat', votes: 3),
    Band(id: '3', name: 'Avicii', votes: 2),
    Band(id: '4', name: 'Redimi2', votes: 4),
  ];

  void addBandToList(BuildContext context, String name) {
    if (name.length > 1) {
      bands.add(Band(
        id: DateTime.now().toString(),
        name: name,
        votes: 0
      ));
    }
    notifyListeners();
  }
}
