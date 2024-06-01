import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailObat extends StatefulWidget {
  final int id;

  DetailObat({required this.id});

  @override
  _DetailObatState createState() => _DetailObatState();
}

class _DetailObatState extends State<DetailObat> {
  String? namaObat;
  String? tanggalKadaluarsa;
  String? stock;
  String? harga;
  String? gambar;

  Future<void> _getObat() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/obat/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        namaObat = data['nama_obat'];
        tanggalKadaluarsa = data['tanggal_kadaluarsa'];
        stock = data['stock'].toString();
        harga = data['harga'].toString();
        gambar = data['gambar'];
      });
    } else {
      print('Failed to load obat data');
    }
  }

  @override
  void initState() {
    super.initState();
    _getObat();
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
          "Detail Obat",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: Image.network(gambar ?? ''),
            ),
            SizedBox(height: 16),
            Text(namaObat ?? ''),
            SizedBox(height: 8),
            Text(tanggalKadaluarsa ?? ''),
            SizedBox(height: 8),
            Text('Stok: $stock'),
            SizedBox(height: 8),
            Text('Harga: $harga'),
          ],
        ),
      ),
    );
  }
}