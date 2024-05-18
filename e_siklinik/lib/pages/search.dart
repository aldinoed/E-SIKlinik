import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/pages/hasil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: const Color(0xFF234DF0))),
                width: double.infinity,
                height: 150,
                child: const Center(
                  child: Text("Cari Riwayat Pasien"),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(
                    color: Color(0xFFEFF0F3),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        // onChanged: _filterDokterList,
                        maxLines: null,
                        decoration: const InputDecoration(
                          hintText: 'Search Here',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Icon(Icons.search),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Terakhir Mengunjungi",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  BoxSearchPage(
                      onTapBox: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Hasil()));
                      },
                      nama: 'Pasien',
                      nrp: '31225000',
                      icon: setIcon(
                          Icons.person_outline, const Color(0xFF234DF0)),
                      prodi: const Text("Tanggal : DD/MM/YYYY"))
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
