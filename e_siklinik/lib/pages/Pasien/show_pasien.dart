import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowPasien extends StatefulWidget {
  final int pasienId;
  const ShowPasien({Key? key, required this.pasienId});

  @override
  State<ShowPasien> createState() => _ShowPasienState();
}

class _ShowPasienState extends State<ShowPasien> {
  Map<String, dynamic>? pasienDetail;

  @override
  void initState() {
    super.initState();
    _getPasienDetail();
  }

  Future<void> _getPasienDetail() async {
    try {
      final response = await http.get(
          Uri.parse("http://192.168.43.246:8080/api/pasien/show/${widget.pasienId}"));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['pasien'] != null) {
          setState(() {
            pasienDetail = data['pasien'];
          });
        }
      } else {
        print("Failed to load pasien detail");
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pasien'),
      ),
      body: pasienDetail != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'http://192.168.43.246:8080/storage/' +
                            pasienDetail!['image']),
                  ),
                  Text('Nama: ${pasienDetail!['nama']}'),
                  Text('NRP: ${pasienDetail!['nrp']}'),
                  Text('Gender: ${pasienDetail!['gender']}'),
                  Text('Tanggal Lahir: ${pasienDetail!['tanggal_lahir']}'),
                  Text('Alamat: ${pasienDetail!['alamat']}'),
                  Text('Nomor HP: ${pasienDetail!['nomor_hp']}'),
                  Text('Nomor Wali: ${pasienDetail!['nomor_wali']}'),
                  Text('Prodi ID: ${pasienDetail!['prodi_id']}'),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
