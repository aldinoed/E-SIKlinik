import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RiwayatCheckup extends StatefulWidget {
  const RiwayatCheckup({super.key});

  @override
  State<RiwayatCheckup> createState() => _RiwayatCheckupState();
}

class _RiwayatCheckupState extends State<RiwayatCheckup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop((context));
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Riwayat Check Up",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
