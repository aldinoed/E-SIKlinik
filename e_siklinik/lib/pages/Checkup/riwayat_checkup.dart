import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RiwayatCheckup extends StatefulWidget {
  final int checkupId;
  const RiwayatCheckup({super.key, required this.checkupId});

  @override
  State<RiwayatCheckup> createState() => _RiwayatCheckupState();
}

class _RiwayatCheckupState extends State<RiwayatCheckup> {
  Map<String, dynamic>? checkupDetail;
  @override
  void initState() {
    super.initState();
    _getCheckupDetail();
  }

  Future<void> _getCheckupDetail() async {
    try {
      final response = await http.get(
        Uri.parse(
            "http://192.168.100.66:8080/api/checkup-result/show/${widget.checkupId}"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['results'] != null) {
          setState(() {
            checkupDetail = data['results'];
            print(checkupDetail);
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load riwayat checkup");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF9F9FB),
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
            "Riwayat Check Up",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: checkupDetail != null
            ? SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Tanggal Check Up",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("${checkupDetail!['created_at']}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF62636C),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Informasi Pasien",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          setInfoPasien("NRP",
                              "${checkupDetail!['pasien_nrp, pasien.nrp']}"),
                          setInfoPasien("Nama",
                              "${checkupDetail!['nama_pasien, pasien.id']}"),
                          setInfoPasien(
                              "Program Studi", "${checkupDetail!['nama']}"),
                          setInfoPasien(
                              "Gender", "${checkupDetail!['gender']}"),
                          setInfoPasien("Tanggal Lahir",
                              "${checkupDetail!['tanggal_lahir']}"),
                          setInfoPasien(
                              "Alamat", "${checkupDetail!['alamat']}"),
                          setInfoPasien(
                              "No Hp", "${checkupDetail!['nomor_hp']}"),
                          setInfoPasien(
                              "No Wali", "${checkupDetail!['nomor_wali']}"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Informasi Dokter",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${checkupDetail!['nama_dokter, dokter.id']}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF62636C),
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Hasil Check Up",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text("${checkupDetail!['hasil_diagnosa']}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF62636C),
                              )),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 125,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Resep  Obat",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          setResepObat("1.", "Paracetamol", "3x3 Hari"),
                          setResepObat("2.", "Amoxicillin", "3x5 Hari"),
                          setResepObat("3.", "Antimo", "1x3 Hari"),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }
}

Widget setInfoPasien(String label, String value) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF62636C),
                )),
            const Text(":",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF62636C),
                ))
          ],
        ),
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text(value,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Color(0xFF62636C),
            )),
      )
    ],
  );
}

Widget setResepObat(String id, String nama, String ket) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(id),
      const SizedBox(
        width: 2,
      ),
      Text(nama),
      const SizedBox(
        width: 5,
      ),
      Text(ket,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ))
    ],
  );
}
