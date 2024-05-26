import 'package:e_siklinik/pages/Obat/addObat.dart';
import 'package:e_siklinik/pages/Obat/add_obat.dart';
import 'package:e_siklinik/pages/Obat/detail_obat.dart';
import 'package:e_siklinik/testing/obat/addObat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataObat extends StatefulWidget {
  const DataObat({Key? key}) : super(key: key);

  @override
  State<DataObat> createState() => _DataObatState();
}

class Obat {
  final int id;
  final String nama;
  final String kategori;
  final DateTime exp;
  final int stok;

  Obat(
      {required this.id,
      required this.nama,
      required this.kategori,
      required this.exp,
      required this.stok});
}

class _DataObatState extends State<DataObat> {
  final String apiGetAllObat = "http://10.0.2.2:8000/api/obat";
  List<dynamic> obatList = [];

  String query = '';
  TextEditingController _searchController = TextEditingController();

  Future<void> _getAllObat() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllObat));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['obats'] != null) {
          setState(() {
            obatList = data['obats'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load obat");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  List<Obat> obat_obat = [
    Obat(
      id: 1,
      nama: 'Paracetamol',
      kategori: 'Obat Keras',
      exp: DateTime(2024, 12, 31),
      stok: 100,
    ),
    Obat(
      id: 2,
      nama: 'Loratadine',
      kategori: 'Bebas',
      exp: DateTime(2023, 10, 15),
      stok: 50,
    ),
    Obat(
      id: 3,
      nama: 'Asam Mefenamat',
      kategori: 'OHT',
      exp: DateTime(2025, 5, 20),
      stok: 80,
    ),
    Obat(
      id: 4,
      nama: 'Serbuk Jahe',
      kategori: 'Jamu',
      exp: DateTime(2023, 8, 10),
      stok: 30,
    ),
    Obat(
      id: 5,
      nama: 'Multivitamin',
      kategori: 'FIT',
      exp: DateTime(2023, 6, 25),
      stok: 120,
    ),
    Obat(
      id: 6,
      nama: 'Morphine',
      kategori: 'Narkotika',
      exp: DateTime(2024, 4, 5),
      stok: 10,
    ),
    Obat(
      id: 7,
      nama: 'Nikotin',
      kategori: 'Bebas Terbatas',
      exp: DateTime(2024, 4, 5),
      stok: 10,
    ),
  ];

  String getLogoByCategory(String category) {
    switch (category) {
      case 'Obat Keras':
        return 'assets/images/obat.png';
      case 'Bebas':
        return 'assets/images/OBAT_BEBAS.png';
      case 'OHT':
        return 'assets/images/OHT.png';
      case 'Jamu':
        return 'assets/images/JAMU.png';
      case 'FIT':
        return 'assets/images/FITOFARMAKA.png';
      case 'Narkotika':
        return 'assets/images/narkotik.png';
      case 'Bebas Terbatas':
        return 'assets/images/OBT.png';
      default:
        return 'assets/images/obat.png';
    }
  }

  List<Obat> filteredData = [];

  @override
  void initState() {
    super.initState();
    // _getAllObat();
    filteredData = List<Obat>.from(obat_obat);
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      filteredData = obat_obat
          .where(
              (obat) => obat.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Database Obat",
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_left,
              size: 50, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(200, 235, 242, 255),
                  labelText: 'Cari Obat',
                  labelStyle: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 2.5),
              ),
              itemCount: filteredData.length, // Use filteredData length
              itemBuilder: (BuildContext context, int index) {
                final obat =
                    filteredData[index]; // Access obat from filteredData
                return IntrinsicHeight(
                  child: Card(
                    elevation: 3,
                    child: GestureDetector(
                      behavior: HitTestBehavior
                          .translucent, // Allow scrolling when clicking on the card
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailObat(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 11,
                                backgroundColor: Colors.transparent,
                                child: Image.asset(
                                  getLogoByCategory(obat.kategori),
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              trailing: Container(
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.more_vert),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    obat.nama, // Use obat.nama instead of filteredData[index]
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('EXP: '),
                                  Text('Stok: ${obat.stok}')
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     mainAxisSpacing: 8.0,
            //     crossAxisSpacing: 8.0,
            //     childAspectRatio: MediaQuery.of(context).size.width /
            //         (MediaQuery.of(context).size.height / 2.5),
            //   ),
            //   // itemCount: obatList.length,
            //   // itemBuilder: (BuildContext context, int index) {
            //   itemCount: filteredData.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     // final obat = obatList[index];
            //     return IntrinsicHeight(
            //       child: Card(
            //         elevation: 3,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(10.0),
            //             color: Colors.white,
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               ListTile(
            //                 leading: CircleAvatar(
            //                   radius: 10,
            //                   backgroundColor: Colors.transparent,
            //                   child: Image.asset(
            //                     'assets/images/obat.png',
            //                     width: 40,
            //                     height: 40,
            //                     fit: BoxFit.fill,
            //                   ),
            //                 ),
            //                 trailing: Container(
            //                   child: IconButton(
            //                     onPressed: () {},
            //                     icon: Icon(Icons.more_vert),
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.symmetric(horizontal: 10),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     // Text(obat['nama_obat'],
            //                     //     style: TextStyle(
            //                     //         fontWeight: FontWeight.bold,
            //                     //         fontSize: 20)),
            //                     // Text(
            //                     //     'EXP: ${obat['tanggal_kadaluarsa'] ?? '-'}'),
            //                     // Text('Stok: ${obat['stock'] ?? '-'}')
            //                     Text(filteredData[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            //                     Text('EXP: '),
            //                     Text('Stok')
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => AddObatNew())));
        },
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
