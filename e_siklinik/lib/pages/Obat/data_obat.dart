import 'package:e_siklinik/pages/Obat/addObat.dart';
import 'package:e_siklinik/pages/Obat/edit_obat.dart';
import 'package:e_siklinik/pages/Obat/detail_obat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DataObat extends StatefulWidget {
  const DataObat({Key? key}) : super(key: key);

  @override
  State<DataObat> createState() => _DataObatState();
}

class _DataObatState extends State<DataObat> {
  final String apiGetAllObat = "http://192.168.100.66:8080/api/obat";
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
    switch (kategoriObat) {
      case 1:
        return 'assets/images/OB.png';
      case 2:
        return 'assets/images/OBT.png';
      case 3:
        return 'assets/images/OK.png';
      case 4:
        return 'assets/images/ON.png';
      case 5:
        return 'assets/images/OJ.png';
      case 6:
        return 'assets/images/OH.png';
      case 7:
        return 'assets/images/OF.png';
      default:
        return 'assets/images/OD.png';
    }
  }

  void _showBottomSheet(BuildContext context, dynamic obat) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UpdateObatNew(id: obat['id'].toString()),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  _deleteObat(obat['id']);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
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
                                  builder: ((context) =>
                                      DetailObat(id: obat['id']))),
                            );
                          },
                          child: IntrinsicHeight(
                            child: Card(
                              elevation: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      trailing: GestureDetector(
                                        onTap: () {
                                          _showBottomSheet(context, obat);
                                        },
                                        child: Icon(Icons.more_vert),
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
                                          Text('Stok: ${obat['stock'] ?? '-'}')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
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

  Future<void> _deleteObat(int id) async {
    final String apiUrl = "http://192.168.100.66:8080/api/obat/$id";

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print("Data obat dengan ID $id berhasil dihapus.");
        _getAllObat();
      } else {
        print(
            "Gagal menghapus data obat dengan ID $id. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }
}
