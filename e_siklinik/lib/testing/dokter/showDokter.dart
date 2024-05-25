import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowDokterPage extends StatefulWidget {
  final int dokterId;
  const ShowDokterPage({Key? key, required this.dokterId});

  @override
  State<ShowDokterPage> createState() => _ShowDokterPageState();
}

class _ShowDokterPageState extends State<ShowDokterPage> {
  Map<String, dynamic>? dokterDetail;

  @override
  void initState() {
    super.initState();
    _getDokterDetail();
  }

  Future<void> _getDokterDetail() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.246:8080/api/dokter/show/${widget.dokterId}"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['dokter'] != null) {
          setState(() {
            dokterDetail = data['dokter'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load dokter detail");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Dokter'),
      ),
      body: dokterDetail != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://192.168.43.246:8080/storage/' + dokterDetail!['image'],
                    ),
                  ),
                  Text('Nama: ${dokterDetail!['nama']}'),
                  Text('Gender: ${dokterDetail!['gender']}'),
                  Text('Tanggal Lahir: ${dokterDetail!['tanggal_lahir']}'),
                  Text('Alamat: ${dokterDetail!['alamat']}'),
                  Text('Nomor HP: ${dokterDetail!['nomor_hp']}'),
                  Text('Hari: ${dokterDetail!['dokter_to_jadwal'][0]['hari']}'),
                  Text('Jam Mulai: ${dokterDetail!['dokter_to_jadwal'][0]['jadwal_mulai_tugas']}'),
                  Text('Jam Selesai: ${dokterDetail!['dokter_to_jadwal'][0]['jadwal_selesai_tugas']}'),
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}