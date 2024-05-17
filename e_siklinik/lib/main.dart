import 'package:e_siklinik/components/header.dart';
import 'package:e_siklinik/pages/Antrian/add_antrian.dart';
import 'package:e_siklinik/pages/dashboard.dart';
import 'package:e_siklinik/pages/data.dart';
import 'package:e_siklinik/pages/search.dart';
import 'package:e_siklinik/testing/antrian/addAntrian.dart';
import 'package:e_siklinik/testing/antrian/assesmentList.dart';
import 'package:e_siklinik/testing/antrian/listAntrian.dart';
import 'package:e_siklinik/testing/checkup/listCheckup.dart';
import 'package:e_siklinik/testing/dokter/listDokter.dart';
import 'package:e_siklinik/testing/obat/listKategoriObat.dart';
import 'package:e_siklinik/testing/obat/listObat.dart';
import 'package:e_siklinik/testing/pasien/listPasien.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import 'package:fluttericon/font_awesome_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // a variable to store the current selected tab. can be used to control PageView
  int _selectedIndex = 0;
  final List<Widget> _children = [
    const Dashboard(),
    const Search(),
    const Data(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AssesmentList() 
      // (
      //   backgroundColor: Color(0xFFF9F9FB),
      //   drawer: const Drawer(),
      //   appBar: const Header(),
      //   body: _children[_selectedIndex],
      //   // backgroundColor: Colors.deepPurple[400],
      //   // you can use the molten bar in the scaffold's bottomNavigationBar
      //   bottomNavigationBar: MoltenBottomNavigationBar(
      //     borderColor: const Color(0xFFD9D9D9),
      //     borderSize: 1,
      //     selectedIndex: _selectedIndex,
      //     domeHeight: 25,
      //     domeCircleColor: const Color(0xFF234DF0),
      //     // specify what will happen when a tab is clicked
      //     onTabChange: (clickedIndex) {
      //       setState(() {
      //         _selectedIndex = clickedIndex;
      //       });
      //     },
      //     // ansert as many tabs as you like
      //     tabs: [
      //       MoltenTab(
      //         icon: const Icon(Icons.dashboard_rounded),
      //         title: const Text('Dashboard'),

      //         // selectedColor: Colors.yellow,
      //       ),
      //       MoltenTab(
      //         icon: const Icon(Icons.search),
      //         title: const Text('Search'),
      //         // selectedColor: Colors.yellow,
      //       ),
      //       MoltenTab(
      //           icon: const Icon(FontAwesome.database),
      //           title: const Text('Data')
      //           // selectedColor: Colors.yellow,
      //           ),
      //     ],
      //   ),
      //  )
      );
  }
}