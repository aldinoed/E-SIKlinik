import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditJadwal extends StatefulWidget {
  final Map<String, dynamic> jadwal;

  const EditJadwal({super.key, required this.jadwal});

  @override
  State<EditJadwal> createState() => _EditJadwalState();
}

class _EditJadwalState extends State<EditJadwal> {
  final String apiGetAllDokter = "http://192.168.100.66:8080/api/dokter";
  List<dynamic> dokterList = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedDokterId;

  final List<String> days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jum\'at'];
  late String _hariController;
  late TextEditingController _jamMulaiController;
  late TextEditingController _jamSelesaiController;

  @override
  void initState() {
    super.initState();
    _selectedDokterId = widget.jadwal['dokter_id'].toString();
    _hariController = widget.jadwal['hari'];
    _jamMulaiController =
        TextEditingController(text: widget.jadwal['jadwal_mulai_tugas']);
    _jamSelesaiController =
        TextEditingController(text: widget.jadwal['jadwal_selesai_tugas']);
    _getAllDokter();
  }

  @override
  void dispose() {
    _jamMulaiController.dispose();
    _jamSelesaiController.dispose();
    super.dispose();
  }

  Future<void> _updateJadwalDokter() async {
    if (_selectedDokterId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dokter tidak boleh kosong'),
        ),
      );
      return;
    }

    final id = widget.jadwal['id'];
    final url = Uri.parse('http://192.168.100.66:8080/api/jadwal_dokter/update/$id');
    final request = http.MultipartRequest('POST', url);

    request.fields['dokter_id'] = _selectedDokterId!;
    request.fields['hari'] = _hariController;
    request.fields['jadwal_mulai_tugas'] = _jamMulaiController.text;
    request.fields['jadwal_selesai_tugas'] = _jamSelesaiController.text;

    final response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Data jadwal dokter berhasil diperbarui'),
        ),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal memperbarui data jadwal dokter'),
        ),
      );
    }
  }

  Future<void> _getAllDokter() async {
    try {
      final response = await http.get(Uri.parse(apiGetAllDokter));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data != null && data['dokter'] != null) {
          setState(() {
            dokterList = data['dokter'];
          });
        } else {
          print("No data received from API");
        }
      } else {
        print("Failed to load dokter");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller, bool isStartTime) async {
    dynamic time = parseTimeOfDay(controller.text);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (picked != null) {
      final now = DateTime.now();
      final selectedTime =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
      final formattedTime =
          "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        backgroundColor: Colors.white,
        elevation: 2,
        shadowColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "Edit Jadwal",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    offset: const Offset(-1, 2),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Informasi Dokter",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFEFF0F3),
                      ),
                      child: DropdownButtonFormField<String>(
                        value: _selectedDokterId,
                        onChanged: (value) {
                          setState(() {
                            _selectedDokterId = value;
                          });
                        },
                        items: dokterList.map((dokter) {
                          return DropdownMenuItem<String>(
                            value: dokter['id'].toString(),
                            child: Text(dokter['nama']),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                            hintText: "Nama Dokter",
                            border: InputBorder.none),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Dokter tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Hari Tugas",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Container(
                      height: 50,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color(0xFFEFF0F3),
                      ),
                      child: DropdownButtonFormField(
                        value: _hariController,
                        onChanged: (value) {
                          setState(() {
                            _hariController = value!;
                          });
                        },
                        items: days.map<DropdownMenuItem<String>>((day) {
                          return DropdownMenuItem<String>(
                            value: day,
                            child: Text(day),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                            hintText: "Hari Tugas", border: InputBorder.none),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Jam Tugas",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color(0xFFEFF0F3)),
                            child: TextFormField(
                              controller: _jamMulaiController,
                              readOnly: true,
                              onTap: () =>
                                  _selectTime(context, _jamMulaiController, true),
                              decoration: const InputDecoration(
                                  hintText: "Jam Mulai",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Jam mulai tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        const Text(
                          " - ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 2),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                color: Color(0xFFEFF0F3)),
                            child: TextFormField(
                              controller: _jamSelesaiController,
                              readOnly: true,
                              onTap: () =>
                                  _selectTime(context, _jamSelesaiController, false),
                              decoration: const InputDecoration(
                                  hintText: "Jam Selesai",
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Jam selesai tidak boleh kosong';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _updateJadwalDokter();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF234DF0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFCFCFD)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
