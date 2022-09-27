import 'dart:io';

import 'package:band_names/services/socket_service.dart';
import 'package:band_names/view/widgets/alertdialogs/ad_android.dart';
import 'package:band_names/view/widgets/alertdialogs/ad_ios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../models/bands/band_model.dart';

List<Band> bands = [];

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('active-bands', ((data) {
      bands = (data as List).map((band) => Band.fromMap(band)).toList();
      setState(() {});
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    socketService.socket.on('active-bands', ((data) {
      bands = (data as List).map((band) => Band.fromMap(band)).toList();
    }));

    Map<String, double> dataBands = {};
    for (var band in bands) {
      dataBands.putIfAbsent(band.name, () => band.votes!.toDouble());
    }

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.online)
                ? Icon(Icons.check_circle, color: Colors.blue[300])
                : const Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: Column(
        children: [
          _ShowGraph(),
          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, index) => _BandTile(band: bands[index])),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (Platform.isAndroid) {
            showDialog(
                context: context,
                builder: (context) => AlertDialogAndroid(bands: bands));
          } else {
            showCupertinoDialog(
                context: context,
                builder: (context) => AlertDialogIos(bands: bands));
          }
        },
        elevation: 1,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ShowGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataBands = {};
    for (var band in bands) {
      dataBands.putIfAbsent(band.name, () => band.votes!.toDouble());
    }

    final List<Color> colorList = [
      Colors.blue[50]!,
      Colors.blue[200]!,
      Colors.pink[50]!,
      Colors.pink[200]!,
      Colors.yellow[50]!,
      Colors.yellow[200]!,
    ];
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: PieChart(
        dataMap: dataBands,
        animationDuration: const Duration(milliseconds: 800),
        chartValuesOptions: ChartValuesOptions(
          showChartValuesInPercentage: true,
          showChartValues: true,
          showChartValuesOutside: false,
          chartValueBackgroundColor: Colors.grey[200],
          decimalPlaces: 0,
        ),
        colorList: colorList,
        chartType: ChartType.ring,
        legendOptions: const LegendOptions(showLegends: true),
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
    final socketService = Provider.of<SocketService>(context);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (_) {
        socketService.emit('delete-band', {
          'id': band.id,
        });
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
        onTap: () {
          socketService.emit('vote-band', {'id': band.id});
        },
      ),
    );
  }
}
