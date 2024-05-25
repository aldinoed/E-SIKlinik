import 'dart:convert';
import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/pages/hasil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> checkupList = [];
  final String apiGetCheckup = "http://192.168.43.246:8080/api/checkup-result";

  @override
  void initState() {
    super.initState();
    _getAllCheckup();
  }

  Future<void> _getAllCheckup() async {
    try {
      final response = await http.get(Uri.parse(apiGetCheckup));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['checkup'] != null) {
          setState(() {
            checkupList = data['checkup'];
          });
          print(checkupList);
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load checkup data");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                _buildHeader(),
                const SizedBox(height: 10),
                _buildSearchField(),
                const SizedBox(height: 10),
                const Text(
                  "Terakhir Checkup",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                _buildCheckupList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(color: const Color(0xFF234DF0)),
      ),
      width: double.infinity,
      height: 150,
      child: const Center(
        child: Text("Cari Riwayat Pasien"),
      ),
    );
  }

  Widget _buildSearchField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0xFFEFF0F3),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
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
    );
  }

  Widget setIcon(IconData iconData, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: const Color(0xFFDDEAFF),
      ),
      child: Icon(
        iconData,
        color: iconColor,
      ),
    );
  }

  Widget _buildCheckupList() {
    return checkupList.isEmpty
        ? const Center(
            child: Text(
              'Checkup Kosong',
              style: TextStyle(fontSize: 18.0),
            ),
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: checkupList.length,
            itemBuilder: (BuildContext context, int index) {
              final checkup = checkupList[index];
              return BoxSearchPage(
                onTapBox: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const Hasil()));
                },
                nama: checkup['check_up_resul_to_assesmen']['assesmen_to_antrian']
                    ['antrian_to_pasien']['nama'],
                nrp: checkup['check_up_resul_to_assesmen']['assesmen_to_antrian']
                    ['antrian_to_pasien']['nrp'],
                icon: setIcon(Icons.person_outline, const Color(0xFF234DF0)),
                prodi: Text(
                  checkup['check_up_resul_to_assesmen']['assesmen_to_antrian']
                      ['antrian_to_pasien']['pasien_to_prodi']['nama'],
                ),
              );
            },
          );
  }
}

// Card(
              //   child: ListTile(
              //     title: Text(checkup['hasil_diagnosa'].toString()),
              //     subtitle: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(checkup['check_up_resul_to_assesmen']['assesmen_to_antrian']
              //             ['antrian_to_pasien']['nama']),
              //         Text(checkup['check_up_resul_to_assesmen']['assesmen_to_antrian']
              //             ['antrian_to_pasien']['pasien_to_prodi']['nama']),
              //         Text(checkup['check_up_resul_to_assesmen']
              //             ['assesmen_to_dokter']['nama']),
              //       ],
              //     ),
              //     trailing: SizedBox(
              //       width: 100,
              //       child: ListView.builder(
              //         shrinkWrap: true,
              //         itemCount: checkup['check_up_result_to_detail_resep'].length,
              //         itemBuilder: (BuildContext context, int resepIndex) {
              //           final resep = checkup['check_up_result_to_detail_resep'][resepIndex];
              //           return Text(resep['detail_resep_to_obat']['nama_obat']);
              //         },
              //       ),
              //     ),
              //   ),
              // );