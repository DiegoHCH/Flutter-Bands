import 'package:band_names/viewmodels/bands/bands_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:band_names/view/home/home_view.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(create: (context) => BandsViemodel())
  ],
  child: const MyApp()
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeView()
      },
    );
  }
}