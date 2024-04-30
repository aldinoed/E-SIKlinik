import 'package:e_siklinik/components/header.dart';
import 'package:e_siklinik/pages/dashboard.dart';
import 'package:e_siklinik/pages/data.dart';
import 'package:e_siklinik/pages/search.dart';
import 'package:e_siklinik/testing/addPasien.dart';
import 'package:e_siklinik/testing/listPasien.dart';
import 'package:e_siklinik/testing/listProdi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

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
    return MaterialApp(home: ListPasienPage()
        // drawer: const Drawer(),
        // appBar: const Header(),
        //   body: _children[_selectedIndex],
        //   // backgroundColor: Colors.deepPurple[400],
        //   // you can use the molten bar in the scaffold's bottomNavigationBar
        //   bottomNavigationBar: MoltenBottomNavigationBar(
        //     borderColor: const Color(0xFFD9D9D9),
        //     borderSize: 1,
        //     selectedIndex: _selectedIndex,
        //     domeHeight: 25,
        //     domeCircleColor: const Color(0xFFB7D1FF),
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
        //         icon: const Icon(Icons.document_scanner_rounded),
        //         title: const Text('Data')
        //         // selectedColor: Colors.yellow,
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
