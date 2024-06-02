import 'package:flutter/material.dart';
import 'package:e_siklinik/pages/Obat/addObat.dart';
import 'package:e_siklinik/testing/obat/addObat.dart';
import 'package:e_siklinik/pages/Obat/detail_obat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeletedObatData extends StatefulWidget {
  const DeletedObatData({super.key});

  @override
  State<DeletedObatData> createState() => _DeletedObatDataState();
}

class _DeletedObatDataState extends State<DeletedObatData> {
  final String apiGetAllObat =
      "http://10.0.2.2:8000/api/obat/deleted-obat";
  List<dynamic> obatList = [];
  List<dynamic> searchObat = [];

  TextEditingController _searchController = TextEditingController();

  Future<void> _getAllObat() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllObat));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['obats'] != null) {
          setState(() {
            obatList = data['obats'];
            searchObat = obatList;
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

  @override
  void initState() {
    super.initState();
    _getAllObat();
    _searchController.addListener(() {
      _searchObat(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _searchObat(String query) {
    final searchResults = obatList.where((obat) {
      final namaObat = obat['nama_obat'].toLowerCase();
      final input = query.toLowerCase();
      return namaObat.contains(input);
    }).toList();

    setState(() {
      searchObat = searchResults;
    });
  }

  String _getImage(int kategoriObat) {
    if (kategoriObat == 1) {
      return 'assets/images/OB.png';
    } else if (kategoriObat == 2) {
      return 'assets/images/OBT.png';
    } else if (kategoriObat == 3) {
      return 'assets/images/OK.png';
    } else if (kategoriObat == 4) {
      return 'assets/images/ON.png';
    } else if (kategoriObat == 5) {
      return 'assets/images/OJ.png';
    } else if (kategoriObat == 6) {
      return 'assets/images/OH.png';
    } else if (kategoriObat == 7) {
      return 'assets/images/OF.png';
    } else {
      return 'assets/images/OD.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Database Obat",
          style: TextStyle(fontWeight: FontWeight.w600),
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
            child: searchObat.isEmpty
                ? Center(
                    child: Image.asset(
                      'assets/images/obat_kosong.png',
                      fit: BoxFit.cover,
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      childAspectRatio: MediaQuery.of(context).size.width /
                          (MediaQuery.of(context).size.height / 2.5),
                    ),
                    itemCount: searchObat.length,
                    itemBuilder: (BuildContext context, int index) {
                      final obat = searchObat[index];
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowObat(
                                  obatId: obat,
                                ),
                              ),
                            );
                          },
                          child: Dismissible(
                            key: Key(obat['id'].toString()),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                obatList.removeWhere(
                                    (item) => item['id'] == obat['id']);
                                searchObat.removeAt(index);
                              });
                            },
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            child: IntrinsicHeight(
                              child: Card(
                                elevation: 3,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.transparent,
                                          child: Image.asset(
                                            _getImage(obat['kategori_id']),
                                            width: 40,
                                            height: 40,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.more_vert),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(obat['nama_obat'],
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            Text(
                                                'EXP: ${obat['tanggal_kadaluarsa'] ?? '-'}'),
                                            Text(
                                                'Stok: ${obat['stock'] ?? '-'}')
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
