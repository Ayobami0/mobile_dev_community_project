import 'package:flutter/material.dart';
import 'package:mobile_dev_com_dashboard/widgets/drawer.dart';
import 'package:mobile_dev_com_dashboard/widgets/widows_data.dart';
import 'charts_ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Rubik',
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
        ),
        drawer: const DrawerWidget(),
        body: const Home(),
      ),
      routes: {
        WidowsData.routeName: (context) => const WidowsData()
      },
    );
  }
}