import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPasien extends StatefulWidget {
  const DataPasien({super.key});

  @override
  State<DataPasien> createState() => _DataPasienState();
}

class _DataPasienState extends State<DataPasien> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text("Data Pasien", style: TextStyle(fontWeight: FontWeight.w600),),
      ),
      body: const Center(child: Text("Haloooo")),
    );
  }
}