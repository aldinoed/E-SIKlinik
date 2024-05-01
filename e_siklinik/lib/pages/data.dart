import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/pages/data_dokter.dart';
import 'package:e_siklinik/pages/data_obat.dart';
import 'package:e_siklinik/pages/data_pasein.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/rpg_awesome_icons.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFD9D9D9),
                ),
                width: double.infinity,
                height: 150,
                child: const Center(
                  child: Text("Grafik ?"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Database",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Box(
                    title: "Pasien",
                    desc: "Add, Edit, Delete Data\nPasien",
                    bgimage: '',
                    icon: setIcon(Icons.person_outline, const Color(0xFF234DF0)),
                    onTapBox: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataPasien()));
                    },
                  ),
                  Box(
                    title: "Dokter",
                    desc: "Add, Edit, Delete Data\nDokter",
                    bgimage: '',
                    icon: setIcon(FontAwesome.stethoscope, const Color(0xFF234DF0)),
                    onTapBox: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataDokter()));
                    },
                  ),
                  Box(
                    title: "Obat",
                    desc: "Add, Edit, Delete Data\nObat",
                    bgimage: '',
                    icon: setIcon(RpgAwesome.pill, const Color(0xFF234DF0)),
                    onTapBox: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DataObat()));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

Widget setIcon(IconData iconData, Color iconColor) {
  return Container(
    padding: const EdgeInsets.all(5),
    decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFFDDEAFF)),
    child: Icon(
      iconData,
      color: iconColor,
    ),
  );
}
