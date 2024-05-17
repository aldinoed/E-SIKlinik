import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddCheckupResult extends StatefulWidget {
  final int assesmentId;
  const AddCheckupResult({Key? key, required this.assesmentId});

  @override
  State<AddCheckupResult> createState() => _AddCheckupResultState();
}

class _AddCheckupResultState extends State<AddCheckupResult> {
  final TextEditingController hasilDiagnosaController = TextEditingController();
  final TextEditingController jumlahPemakaianController = TextEditingController();
  final TextEditingController waktuPemakaianController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  final String apiPostCheckupResult = "http://10.0.2.2:8000/api/checkup-obat/insert";
  final String apiGetAllObat = "http://10.0.2.2:8000/api/obat";

  List<dynamic> obatList = [];
  Map<String, dynamic>? assesmentDetail;
  File? _imageFile;
  int? obatId;

  @override
  void initState() {
    super.initState();
    _getAssesmentDetail();
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
        print("Failed to load Data Obat");
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> _getAssesmentDetail() async {
    try {
      final response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/checkup-assesmen/show/${widget.assesmentId}"),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['results'] != null) {
          setState(() {
            assesmentDetail = data['results'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load assesment detail");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> addCheckupWithResepObat(BuildContext context) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiPostCheckupResult));
      request.fields['hasil_diagnosa'] = hasilDiagnosaController.text;
      request.fields['assesmen_id'] = widget.assesmentId.toString();
      request.fields['obat_id'] = obatId.toString();
      request.fields['jumlah_pemakaian'] = jumlahPemakaianController.text;
      request.fields['waktu_pemakaian'] = waktuPemakaianController.text;

      if (_imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',
            _imageFile!.path,
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil ditambahkan')),
        );
      } else {
        final errorData = json.decode(await response.stream.bytesToString());
        print('Gagal menambahkan data: ${errorData['message']}');
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
          "Add Checkup",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Nama Pasien: ${assesmentDetail?['nama_pasien']}'),
              Text('Nama Prodi: ${assesmentDetail?['nama_prodi']}'),
              Text('Nama Dokter: ${assesmentDetail?['nama_dokter']}'),
              Text('No Antrian: ${assesmentDetail?['no_antrian']}'),
              TextFormField(
                controller: hasilDiagnosaController,
                decoration: const InputDecoration(
                  labelText: "Deskripsi",
                ),
              ),
               TextFormField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Image (Opsional)",
              ),
              readOnly: true,
              onTap: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (pickedFile != null) {
                  setState(() {
                    _imageFile = File(pickedFile.path);
                    imageController.text = _imageFile!.path.split('/').last;
                  });
                }
              },
            ),
              DropdownButtonFormField<int>(
                value: obatId,
                onChanged: (value) {
                  setState(() {
                    obatId = value;
                  });
                },
                items: obatList.map<DropdownMenuItem<int>>((obat) {
                  return DropdownMenuItem<int>(
                    value: obat['id'],
                    child: Text(obat['nama_obat']),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Nama obat",
                ),
              ),
              TextFormField(
                controller: jumlahPemakaianController,
                decoration: const InputDecoration(
                  labelText: "Jumlah Pemakaian",
                ),
              ),
              TextFormField(
                controller: waktuPemakaianController,
                decoration: const InputDecoration(
                  labelText: "Waktu Pemakaian",
                ),
              ),
              ElevatedButton(
                onPressed: () => addCheckupWithResepObat(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.indigo,
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