import 'package:e_siklinik/testing/addPasien.dart';
import 'package:e_siklinik/testing/showPasien.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPasienPage extends StatefulWidget {
  const ListPasienPage({Key? key}) : super(key: key);

  @override
  State<ListPasienPage> createState() => _ListPasienPageState();
}

class _ListPasienPageState extends State<ListPasienPage> {
  final String apiGetAllPasien = "http://10.0.2.2:8000/api/pasien";
  List<dynamic> pasienList = [];

  @override
  void initState() {
    super.initState();
    _getAllPasien();
  }

  Future<void> _getAllPasien() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllPasien));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['pasien'] != null) {
          setState(() {
            pasienList = data['pasien'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load pasien");
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddPasienPage()));
      }),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Data Pasien",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: pasienList.isEmpty
              ? const Center(
                  child: Text(
                    'Tidak ada data pasien',
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : Column(
                children: [
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
                              maxLines: null,
                              decoration: const InputDecoration(
                                hintText: 'Search Here',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: const Icon(Icons.search),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  Flexible(
                    child: ListView.builder(
                        itemCount: pasienList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final pasien = pasienList[index];
                          final pasienId = pasien['id']; // Dapatkan id pasien di sini
                          return Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShowPasienDetail(pasienId: pasienId),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(15)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          offset: const Offset(-1, 2),
                                          blurRadius: 3,
                                          spreadRadius: 0,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              child: setIcon(Icons.person_outline, const Color(0xFF234DF0)),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                pasien['nama'] ?? '',
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                pasien['nrp'] ?? '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w300),
                                              ),
                                              pasien['pasien_to_prodi'] != null
                                                  ? Text(pasien['pasien_to_prodi']
                                                          ['nama'] ??
                                                      '')
                                                  : const Text("G ada prodi"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 15,
                              )
                            ],
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
