import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BandsViemodel extends ChangeNotifier {
  

  void addBandToList(BuildContext context, String name) {
    if (name.length > 1) {
      final sockectService = Provider.of<SocketService>(context, listen: false);

      sockectService.emit('add-band', {
        'name': name,
      });
    }
    notifyListeners();
  }
}
