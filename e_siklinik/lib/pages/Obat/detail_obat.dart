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
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/show'));
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
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.3), // Placeholder color
              ),
              child: Image.network(
                gambar ?? 'https://via.placeholder.com/200', // Placeholder URL
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    namaObat ?? 'Nama Obat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tanggal Kadaluarsa: ${tanggalKadaluarsa ?? "-"}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Stok: ${stock ?? "-"}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Harga: ${harga ?? "-"}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
