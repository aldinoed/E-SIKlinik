import 'package:e_siklinik/pages/Obat/data_obat.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';


class UpdateObatNew extends StatefulWidget {
  final String id;

  const UpdateObatNew({Key? key, required this.id}) : super(key: key);

  @override
  _UpdateObatNewState createState() => _UpdateObatNewState();
}

class _UpdateObatNewState extends State<UpdateObatNew> {
  final TextEditingController namaObatController = TextEditingController();
  final TextEditingController tanggalKadaluarsaController =
      TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  final String apiGetObatDetails =
      "http://192.168.100.66:8080/api/obat/details";
  final String apiGetAllKategori =
      "http://192.168.100.66:8080/api/kategori-obat";

  List<dynamic> kategoriList = [];
  String? _selectedKategori;

  @override
  void initState() {
    super.initState();
    _getObatDetails();
    _getAllKategori();
  }

  Future<void> _getObatDetails() async {
    try {
      final response = await http.get(
        Uri.parse('$apiGetObatDetails/${widget.id}'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null) {
          setState(() {
            namaObatController.text = data['nama_obat'];
            tanggalKadaluarsaController.text = data['tanggal_kadaluarsa'];
            stockController.text = data['stock'];
            hargaController.text = data['harga'];
            _selectedKategori = data['kategori_id'].toString();
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load obat details");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> _getAllKategori() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllKategori));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['kategori'] != null) {
          setState(() {
            kategoriList = data['kategori'];
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

  Future<void> updateObat(BuildContext context) async {
  try {
    var request = http.MultipartRequest('POST', Uri.parse('http://192.168.100.66:8080/api/obat/insert'));
    request.fields['id'] = widget.id;
    request.fields['nama_obat'] = namaObatController.text;
    request.fields['tanggal_kadaluarsa'] = tanggalKadaluarsaController.text;
    request.fields['stock'] = stockController.text;
    request.fields['harga'] = hargaController.text;
    request.fields['kategori_id'] = _selectedKategori.toString();

    var response = await request.send();

    if (response.statusCode == 200) {
      final obat = json.decode(await response.stream.bytesToString())['obats'];
      print('Obat berhasil diperbarui: $obat');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Obat berhasil diperbarui')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => const DataObat()));
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
          "Edit Obat",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
       body: SingleChildScrollView(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
              elevation: 10,
              child: Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Nama Obat',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: const Color.fromARGB(
                                          200, 235, 242, 255),
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
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          hintText: 'Nama Obat',
                                          hintStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                'Kategori Obat',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  fontFamily: 'Urbanist',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              child: Card(
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    color: Color.fromARGB(
                                                        200, 235, 242, 255),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child:
                                                        DropdownButtonFormField<
                                                            String>(
                                                      isExpanded: true,
                                                      icon: ImageIcon(AssetImage(
                                                          "assets/images/Dropdown.png")),
                                                      decoration:
                                                          InputDecoration
                                                              .collapsed(
                                                                  hintText: ""),
                                                      hint: Text(
                                                        "Pilih Kategori Obat",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Urbanist',
                                                          fontSize: 16,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                      value: _selectedKategori,
                                                      items: kategoriList.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (kategori) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            constraints:
                                                                BoxConstraints(
                                                                    minHeight:
                                                                        48.0),
                                                            child: Text(
                                                              kategori[
                                                                  'nama_kategori'],
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Urbanist',
                                                              ),
                                                            ),
                                                          ),
                                                          value: kategori['id']
                                                              .toString(),
                                                        );
                                                      }).toList(),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selectedKategori =
                                                              value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              'Tanggal Kadaluarsa',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            child: Card(
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.5,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Color.fromARGB(
                                                      200, 235, 242, 255),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      child: TextField(
                                                        controller:
                                                            tanggalKadaluarsaController,
                                                        decoration:
                                                            InputDecoration(
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide.none,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          10,
                                                                      vertical:
                                                                          5),
                                                          suffixIcon: Icon(
                                                            Icons
                                                                .calendar_today,
                                                            size: 20,
                                                          ),
                                                          labelText:
                                                              "DD/MM/YYYY",
                                                          labelStyle: TextStyle(
                                                              fontSize:
                                                                  10),
                                                        ),
                                                        readOnly:
                                                            true,
                                                        onTap: () async {
                                                          DateTime? pickedDate =
                                                              await showDatePicker(
                                                            context: context,
                                                            initialDate: DateTime
                                                                .now(),
                                                            firstDate:
                                                                DateTime.now(),
                                                            lastDate:
                                                                DateTime(2101),
                                                          );
                                                          if (pickedDate !=
                                                              null) {
                                                            print(pickedDate);
                                                            String
                                                                formattedDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        pickedDate);
                                                            print(
                                                                formattedDate);
                                                            setState(() {
                                                              tanggalKadaluarsaController
                                                                      .text =
                                                                  formattedDate;
                                                            });
                                                          } else {
                                                            print(
                                                                "Date is not selected");
                                                          }
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Stok Obat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(200, 235, 242, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 9, left: 20),
                                  child: TextField(
                                    controller: stockController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration.collapsed(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          200, 235, 242, 255),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Masukkan Stok Obat',
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Harga Obat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(200, 235, 242, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 9, left: 20),
                                  child: TextField(
                                    controller: hargaController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration.collapsed(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          200, 235, 242, 255),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Masukkan Harga Obat',
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
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Gambar Obat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color:
                                      const Color.fromARGB(200, 235, 242, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 9, bottom: 9, left: 20),
                                  child: TextField(                                   
                                    decoration: InputDecoration.collapsed(
                                      filled: true,
                                      fillColor: const Color.fromARGB(
                                          200, 235, 242, 255),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: 'Pilih Gambar',
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15,
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      final picker = ImagePicker();
                                      final pickedFile = await picker.pickImage(
                                        source: ImageSource.gallery,
                                      );

                                      if (pickedFile != null) {
                                        setState(() {
                                          // _imageFile = File(pickedFile.path);
                                          // imageController.text =
                                          //     _imageFile!.path.split('/').last;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SizedBox(
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 2, color: Colors.blue),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        UpdateObatNew(id: 'context',);
                                      },
                                      child: SizedBox(
                                        child: Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              border: Border.all(
                                                  width: 2, color: Colors.blue),
                                              color: Colors.blue,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10,
                                                      horizontal: 20),
                                                  child: Text(
                                                    'Submit',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ]))))
        ]))
    );
  }
}
