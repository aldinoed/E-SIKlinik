import 'package:e_siklinik/pages/Antrian/add_antrian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Antrian extends StatefulWidget {
  const Antrian({super.key});

  @override
  State<Antrian> createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF234DF0),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddAntrian()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
          "Antrian",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
