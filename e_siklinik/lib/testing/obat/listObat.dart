import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListObatPage extends StatefulWidget {
  const ListObatPage({Key? key}) : super(key: key);

  @override
  State<ListObatPage> createState() => _ListObatPageState();
}

class _ListObatPageState extends State<ListObatPage> {
  final String apiGetAllObat = "http://10.0.2.2:8000/api/obat";

  List<dynamic> obatList = [];

  @override
  void initState() {
    super.initState();
    _getAllObat();
  }

  Future<void> _getAllObat() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllObat));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['obats'] != null) {
          setState(() {
            obatList = data['obats'];
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Obat'),
      ),
      body: obatList.isEmpty
          ? Center(
              child: Text(
                'Tidak ada data obat',
                style: TextStyle(fontSize: 18.0),
              ),
            )
          : ListView.builder(
              itemCount: obatList.length,
              itemBuilder: (BuildContext context, int index) {
                final obat = obatList[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'http://10.0.2.2:8000/storage/' + obat['image'],
                    ),
                  ),
                  title: Text(obat['nama_obat'] ?? ''),
                  subtitle: Text(
                    'Kategori: ${obat['obat_to_kategori_obat']['nama_kategori'] ?? '-'}',
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Stock: ${obat['stock'] ?? '-'}'),
                      Text('Harga: Rp. ${obat['harga'] ?? '-'}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}