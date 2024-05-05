import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddAntrian extends StatefulWidget {
  const AddAntrian({super.key});

  @override
  State<AddAntrian> createState() => _AddAntrianState();
}

class _AddAntrianState extends State<AddAntrian> {
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
          "Tambahkan Antrian",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
