import 'package:e_siklinik/testing/pasien/showPasien.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListDokterPage extends StatefulWidget {
  const ListDokterPage({Key? key}) : super(key: key);

  @override
  State<ListDokterPage> createState() => _ListDokterPageState();
}

class _ListDokterPageState extends State<ListDokterPage> {
  final String apiGetAllDokter = "http://10.0.2.2:8000/api/dokter";
  List<dynamic> dokterList = [];

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
      appBar: AppBar(
        title: Text('Daftar Dokter'),
      ),
      body: dokterList.isEmpty
          ? Center(
              child: Text(
                'Tidak ada data Dokter',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
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
                          'http://10.0.2.2:8000/storage/'+dokter['image']),
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
    );
  }
}
