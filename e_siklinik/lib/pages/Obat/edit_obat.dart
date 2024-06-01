import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditObat extends StatefulWidget {
  final int id;
  final String namaObat;
  final String tanggalKadaluarsa;
  final int stock;
  final int harga;
  final String gambar;

  EditObat({
    required this.id,
    required this.namaObat,
    required this.tanggalKadaluarsa,
    required this.stock,
    required this.harga,
    required this.gambar,
  });

  @override
  _EditObatState createState() => _EditObatState();
}

class _EditObatState extends State<EditObat> {
  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController tanggalKadaluarsaController =
      TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  File? _imageFile;

  @override
  void initState() {
    super.initState();
    namaObatController.text = widget.namaObat;
    tanggalKadaluarsaController.text = widget.tanggalKadaluarsa;
    stockController.text = widget.stock.toString();
    hargaController.text = widget.harga.toString();
  }

  Future<void> _updateObat() async {
    final apiUpdateObat =
        "http://127.0.0.1:8000/api/obat/update/${widget.id}";

    var request = http.MultipartRequest('PUT', Uri.parse(apiUpdateObat));
    request.fields['nama_obat'] = namaObatController.text;
    request.fields['tanggal_kadaluarsa'] = tanggalKadaluarsaController.text;
    request.fields['stock'] = stockController.text;
    request.fields['harga'] = hargaController.text;

    if (_imageFile!= null) {
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
        const SnackBar(content: Text('Obat berhasil diperbarui')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memperbarui obat')),
      );
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile!= null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        imageController.text = _imageFile!.path.split('/').last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Obat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Nama Obat',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(200, 235, 242, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 9, left: 20),
                              child: TextField(
                                controller: namaObatController,
                                decoration: InputDecoration.collapsed(
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                      200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Masukkan Nama Obat',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Tanggal Kadaluarsa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(200, 235, 242, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 9, left: 20),
                              child: TextField(
                                controller: tanggalKadaluarsaController,
                                decoration: InputDecoration.collapsed(
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                      200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Masukkan Tanggal Kadaluarsa',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Stock',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(200, 235, 242, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 9, left: 20),
                              child: TextField(
                                controller: stockController,
                                decoration: InputDecoration.collapsed(
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                      200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Masukkan Stock',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Harga',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),color: const Color.fromARGB(200, 235, 242, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 9, left: 20),
                              child: TextField(
                                controller: hargaController,
                                decoration: InputDecoration.collapsed(
                                  filled: true,
                                  fillColor: const Color.fromARGB(
                                      200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  hintText: 'Masukkan Harga',
                                  hintStyle: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Gambar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: MediaQuery.of(context).size.width / 1.1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromARGB(200, 235, 242, 255),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 9, bottom: 9, left: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      image: DecorationImage(
                                        image: _imageFile != null
                                            ? FileImage(File(_imageFile!.path))
                                            : NetworkImage(widget.gambar) as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                      controller: imageController,
                                      enabled: false,
                                      decoration: InputDecoration.collapsed(
                                        filled: true,
                                        fillColor: const Color.fromARGB(
                                            200, 235, 242, 255),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        hintText: 'Pilih Gambar',
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.image),
                                    onPressed: _selectImage,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateObat,
                child: Text('Simpan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(200, 255, 242, 220),
                  foregroundColor: Colors.black,
                  shadowColor: const Color.fromARGB(255, 160, 170, 180),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void selectImage() async {
  //   final picker = ImagePicker();
  //     final pickedFile = await picker.pickImage(
  //       source: ImageSource.gallery,
  //     );
  //     if (pickedFile != null) {
  //       setState(() {
  //         _imageFile = File(pickedFile.path);
  //         imageController.text =
  //         _imageFile!.path.split('/').last;
  //       });
  //     }
  // }

  // void _updateObat() async {
  // if (namaController.text.isEmpty ||
  //     hargaController.text.isEmpty ||
  //     _imageFile == null) {
  //   Get.snackbar('Error', 'Mohon lengkapi semua field');
  // } else {
  //   final obat = Obat(
  //     id: widget.id,
  //     nama: namaController.text,
  //     tanggalKadaluarsa: tanggalKadaluarsaController.text
  //     stock: int.parse(stockController.text),
  //     harga: int.parse(hargaController.text),
  //     gambar: imageController.text,
  //   );
  //   await obatController.updateObat(obat);
  //   Get.back();
  //   Get.snackbar('Sukses', 'Data obat berhasil diubah');
  // }
  // }
}