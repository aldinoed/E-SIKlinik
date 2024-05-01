import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddPasienPage extends StatefulWidget {
  const AddPasienPage({Key? key}) : super(key: key);

  @override
  State<AddPasienPage> createState() => _AddPasienPageState();
}

class _AddPasienPageState extends State<AddPasienPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nrpController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController noHpController = TextEditingController();
  final TextEditingController noWaliController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();

  final String apiPostPasien = "http://10.0.2.2:8000/api/pasien/create";
  final String apiGetAllProdi = "http://10.0.2.2:8000/api/prodi";

  List<dynamic> prodiList = [];
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _getAllProdi();
  }

  Future<void> _getAllProdi() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllProdi));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['prodi'] != null) {
          setState(() {
            prodiList = data['prodi'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load prodi");
      }
    } catch (error) {
      print('Error : $error');
    }
  }

  Future<void> addPasien(BuildContext context) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiPostPasien));
      request.fields['nama'] = namaController.text;
      request.fields['nrp'] = nrpController.text;
      request.fields['gender'] = genderController.text;
      request.fields['tanggal_lahir'] = tanggalLahirController.text;
      request.fields['alamat'] = alamatController.text;
      request.fields['nomor_hp'] = noHpController.text;
      request.fields['nomor_wali'] = noWaliController.text;
      request.fields['prodi_id'] = prodiController.text;

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
        final pasien =
            json.decode(await response.stream.bytesToString())['pasien'];
        SnackBar(content: Text('Pasien berhasil ditambahkan'));
        print('Pasien berhasil ditambahkan: $pasien');
      } else {
        print('Gagal menambahkan pasien');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Add Pasien",
          style: TextStyle(
            fontSize: 22.0,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: "Nama",
                ),
              ),
              TextFormField(
                controller: nrpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "NRP",
                ),
              ),
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(
                  labelText: "Gender",
                ),
              ),
              TextFormField(
                controller: tanggalLahirController,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      tanggalLahirController.text =
                          pickedDate.toString().split(' ')[0];
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: "Tanggal Lahir",
                ),
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(
                  labelText: "Alamat",
                ),
              ),
              TextFormField(
                controller: noHpController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor HP",
                ),
              ),
              TextFormField(
                controller: noWaliController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Wali",
                ),
              ),
              TextFormField(
                controller: imageController,
                decoration: InputDecoration(
                  labelText: "Image",
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
              DropdownButtonFormField(
                value: null,
                onChanged: (value) {
                  setState(() {
                    prodiController.text = value.toString();
                  });
                },
                items: prodiList.map<DropdownMenuItem>((prodi) {
                  return DropdownMenuItem(
                    value: prodi['id'],
                    child: Text(prodi['nama']),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: "Prodi",
                ),
              ),
              ElevatedButton(
                onPressed: () => addPasien(context),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
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
