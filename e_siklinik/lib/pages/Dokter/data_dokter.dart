import 'dart:convert';
import 'package:e_siklinik/pages/Dokter/add_dokter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataDokter extends StatefulWidget {
  const DataDokter({super.key});

  @override
  State<DataDokter> createState() => _DataDokterState();
}

class _DataDokterState extends State<DataDokter> {
  final String apiGetAllDokter = "http://10.0.2.2:8000/api/dokter";
  List<dynamic> dokterList = [];
  List<dynamic> filteredDokterList = [];

  @override
  void initState() {
    super.initState();
    _getAllDokter();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9FB),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Color(0xFF234DF0),
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
            ? Center(
                child: Text(
                  'Tidak ada data Dokter',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            : SafeArea(
              child: Column(
                children: [
                   Container(
                        margin: EdgeInsets.only(top: 16, right: 16, left: 16),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color(0xFFEFF0F3),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
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
                        itemCount: dokterList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final dokter = dokterList[index];
                          final dokterId = dokter['id']; // Dapatkan id dokter di sini
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         ShowPasienDetail(pasienId: pasienId),
                              //   ),
                              // );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'http://10.0.2.2:8000/storage/' + dokter['image']),
                              ),
                              title: Text(dokter['nama'] ?? ''),
                              subtitle: Text(dokter['gender'] ?? ''),
                              trailing: dokter['dokter_to_jadwal'].isEmpty
                                  ? Text("G ada jadwal")
                                  : Text(dokter['dokter_to_jadwal'][0]['hari'] ??
                                      'G ada hari'),
                            ),
                          );
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
