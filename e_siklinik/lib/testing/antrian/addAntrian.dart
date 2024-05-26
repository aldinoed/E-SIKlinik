import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CreateAntrianPage extends StatefulWidget {
  const CreateAntrianPage({Key? key}) : super(key: key);

  @override
  State<CreateAntrianPage> createState() => _CreateAntrianPageState();
}

class _CreateAntrianPageState extends State<CreateAntrianPage> {
  final TextEditingController pasienIdController = TextEditingController();
  final TextEditingController noAntrianController = TextEditingController();

  final String apiPostAntrian = "http://192.168.18.40:8080/api/antrian/create";

  final String apiGetAllPasien = "http://192.168.18.40:8080/api/pasien";

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
        print("Failed to load kategori obat");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> addAntrian(BuildContext context) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiPostAntrian));
      request.fields['pasien_id'] = pasienIdController.text;
      request.fields['no_antrian'] = noAntrianController.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        final obat = json.decode(
            await response.stream.bytesToString()); // ['obat] coba ga pake ini
        print('Antrian berhasil ditambahkan: $obat');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Antrian berhasil ditambahkan')),
        );

        // Clear input fields
        // pasienIdController.clear();
        // tanggalKadaluarsaController.clear();
        // stockController.clear();
        // hargaController.clear();
        // imageController.clear();
        // noAntrianController.clear();
        // _imageFile = null;
      } else {
        final errorData = json.decode(await response.stream.bytesToString());
        print('Gagal menambahkan obat: ${errorData['message']}');
      }
    } catch (error) {
      print('Error: $error');
    }
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
          "Data Antrian",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField(
                value: null,
                onChanged: (value) {
                  setState(() {
                    pasienIdController.text = value.toString();
                  });
                },
                items: pasienList.map<DropdownMenuItem>((pasien) {
                  return DropdownMenuItem(
                    value: pasien['id'],
                    child: Text(pasien['nama']),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Nama Pasien",
                ),
              ),
              ElevatedButton(
                onPressed: () => addAntrian(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
