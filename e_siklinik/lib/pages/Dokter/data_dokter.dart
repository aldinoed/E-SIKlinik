import 'dart:convert';
import 'package:e_siklinik/components/bottomsheet.dart';
import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/components/delete_confirmation.dart';
import 'package:e_siklinik/pages/Dokter/add_dokter.dart';
import 'package:e_siklinik/pages/Dokter/edit_dokter.dart';
import 'package:e_siklinik/pages/Dokter/show_dokter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class DataDokter extends StatefulWidget {
  const DataDokter({super.key});

  @override
  State<DataDokter> createState() => _DataDokterState();
}

class _DataDokterState extends State<DataDokter> {
  final String apiGetAllDokter = "http://192.168.43.246:8080/api/dokter";
  List<dynamic> dokterList = [];
  List<dynamic> filteredDokterList = [];

  @override
  void initState() {
    super.initState();
    _getAllDokter();
    _refreshData();
  }

  Future<void> _getAllDokter() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllDokter));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['dokter'] != null) {
          setState(() {
            dokterList = data['dokter'];
            filteredDokterList = List.from(dokterList);
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load Data");
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> _refreshData() async {
    await _getAllDokter();
  }

  void _filterDokterList(String searchText) {
    setState(() {
      filteredDokterList = dokterList
          .where((dokter) =>
              dokter['nama'].toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void _deleteItem() {
    print('Item deleted');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF234DF0),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddDokter()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
          "Database Dokter",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: dokterList.isEmpty
            ? const Center(
                child: Text(
                  'Tidak ada data Dokter',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : SafeArea(
                child: Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 16, right: 16, left: 16),
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
                              onChanged: _filterDokterList,
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
                    Flexible(
                      child: ListView.builder(
                        itemCount: filteredDokterList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dokter = filteredDokterList[index];
                          final dokterId =
                              dokter['id']; // Dapatkan id dokter di sini
                          return BoxDokter(
                            onTapBox: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ShowDokter(dokterId: dokterId)));
                            },
                            icon: 'http://192.168.43.246:8080/storage/' +
                                dokter['image'],
                            nama: dokter['nama'] ?? '',
                            onTapPop: () {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => BuildSheet(
                                        onTapEdit: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditDokter(
                                                          dokter: dokter)));
                                        },
                                        onTapDelete: () {
                                          showDeleteConfirmationDialog(
                                              context, _deleteItem);
                                        },
                                      ));
                            },
                          );
                          // GestureDetector(
                          //   onTap: () {
                          //     // Navigator.push(
                          //     //   context,
                          //     //   MaterialPageRoute(
                          //     //     builder: (context) =>
                          //     //         ShowPasienDetail(pasienId: pasienId),
                          //     //   ),
                          //     // );
                          //   },
                          //   child: ListTile(
                          //     leading: CircleAvatar(
                          //       backgroundImage: NetworkImage(
                          // 'http://192.168.43.246:8080/storage/' +
                          //     dokter['image']),
                          //     ),
                          //     title: Text(dokter['nama'] ?? ''),
                          //     subtitle: Text(dokter['gender'] ?? ''),
                          //     trailing: dokter['dokter_to_jadwal'].isEmpty
                          //         ? Text("G ada jadwal")
                          //         : Text(dokter['dokter_to_jadwal'][0]
                          //                 ['hari'] ??
                          //             'G ada hari'),
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
