import 'dart:io';

import 'package:band_names/view/widgets/alertdialogs/ad_android.dart';
import 'package:band_names/view/widgets/alertdialogs/ad_ios.dart';
import 'package:band_names/viewmodels/bands/bands_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../models/bands/band_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bandsViewmodel = Provider.of<BandsViemodel>(context);
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bandsViewmodel.bands.length,
          itemBuilder: (context, index) =>
              _BandTile(band: bandsViewmodel.bands[index])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Platform.isAndroid) {
            showDialog(
                context: context,
                builder: (context) =>
                    AlertDialogAndroid(bands: bandsViewmodel.bands));
          } else {
            showCupertinoDialog(
                context: context,
                builder: (context) =>
                    AlertDialogIos(bands: bandsViewmodel.bands));
          }
        },
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _BandTile extends StatelessWidget {
  const _BandTile({
    required this.band,
  });

  final Band band;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
      },
      background: Container(
        padding: const EdgeInsets.only(left: 20, top: 5),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.trash,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'Delete',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {},
      ),
    );
  }
}
