import 'package:e_siklinik/components/drawerscreen.dart';
import 'package:e_siklinik/components/header.dart';
import 'package:e_siklinik/pages/dashboard.dart';
import 'package:e_siklinik/pages/data.dart';
import 'package:e_siklinik/pages/login.dart';
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
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: const ListDokterPage());
  }
}
