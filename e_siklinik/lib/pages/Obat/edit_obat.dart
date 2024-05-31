import 'package:e_siklinik/pages/Obat/data_obat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditObat extends StatefulWidget {
  final Obat obat;

  const EditObat({Key? key, required this.obat}) : super(key: key);

  @override
  State<EditObat> createState() => _EditObatState();
}

class Obat {
  final int id;
  final String namaObat;
  final String tanggalKadaluarsa;
  final int stock;
  final double harga;
  final int kategoriId;
  Obat({
    required this.id,
    required this.namaObat,
    required this.tanggalKadaluarsa,
    required this.stock,
    required this.harga,
    required this.kategoriId,
  });
}


class _EditObatState extends State<EditObat> {
  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController tanggalKadaluarsaController =
      TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  late String _selectedKategori;

  late File? _imageFile;

  final String apiUpdateObat = "http://127.0.0.1:8000/api/obat/insert";
  final String apiGetAllKategori = "http://127.0.0.1:8000/api/kategori-obat";

  @override
  void initState() {
    super.initState();
    _selectedKategori = widget.obat.kategoriId.toString();
    namaObatController.text = widget.obat.namaObat;
    tanggalKadaluarsaController.text = widget.obat.tanggalKadaluarsa;
    stockController.text = widget.obat.stock.toString();
    hargaController.text = widget.obat.harga.toString();
  }

  Future<void> updateObat(BuildContext context) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse(apiUpdateObat));
    request.fields['id'] = widget.obat.id.toString(); // ID obat yang akan diupdate
    request.fields['nama_obat'] = namaObatController.text;
    request.fields['tanggal_kadaluarsa'] = tanggalKadaluarsaController.text;
    request.fields['stock'] = stockController.text;
    request.fields['harga'] = hargaController.text;
    request.fields['kategori_id'] = _selectedKategori.toString();

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
      final obat = json.decode(await response.stream.bytesToString())['obats'];
      print('Obat berhasil diperbarui: $obat');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Obat berhasil diperbarui')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DataObat()),
      );

    } else {
      final errorData = json.decode(await response.stream.bytesToString());
      print('Gagal memperbarui obat: ${errorData['message']}');
    }
  } catch (error) {
    print('Error: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text(
            "Edit Obat",
            style: TextStyle(),
          ),
          titleTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: '',
              color: Colors.black),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 66,
          leading: Container(
            color: Colors.white,
            child: ButtonBar(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_left,
                    size: 50,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama Obat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: namaObatController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Nama Obat',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Kategori Obat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField<String>(
                  value: _selectedKategori,
                  onChanged: (value) {
                    setState(() {
                      _selectedKategori = value!;
                    });
                  },
                  items: [
                    // Replace with your list of categories
                    DropdownMenuItem(child: Text('Kategori 1'), value: '1'),
                    DropdownMenuItem(child: Text('Kategori 2'), value: '2'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Tanggal Kadaluarsa',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: tanggalKadaluarsaController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Tanggal Kadaluarsa',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Stok Obat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: stockController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Stok Obat',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Harga Obat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Harga Obat',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Gambar Obat',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: _imageFile != null
                              ? _imageFile!.path.split('/').last
                              : 'Pilih Gambar',
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () async {
                        final picker = ImagePicker();
                        final pickedFile =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (pickedFile != null) {
                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Aksi ketika tombol Batal ditekan
                    },
                    child: Text('Batal'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Panggil fungsi untuk mengupdate data obat
                      _updateObat(context);
                    },
                    child: Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateObat(BuildContext context) async {
    // Implementasi fungsi untuk mengupdate data obat ke server
    try {
      // Lakukan request HTTP ke API untuk mengupdate data obat
      // Gunakan widget.obat untuk mendapatkan data obat yang akan diupdate
      // Perbarui data obat sesuai dengan nilai yang dimasukkan oleh pengguna
      // Tampilkan pesan berhasil atau gagal tergantung dari respon server
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Error: $error');
    }
  }
}
