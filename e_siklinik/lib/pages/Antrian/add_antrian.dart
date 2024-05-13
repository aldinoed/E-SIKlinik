import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:e_siklinik/pages/Antrian/antrian.dart';

class AddAntrianPage extends StatefulWidget {
  @override
  _AddAntrianPageState createState() => _AddAntrianPageState();
}

class _AddAntrianPageState extends State<AddAntrianPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientInfoController = TextEditingController();
  String? _selectedDoctor;
  final TextEditingController _dateController = TextEditingController();
  final List<String> _doctorOptions = ['Dr. Ghazi', 'Dr. Angga', 'Dr. Hammam', 'Dr. Ian', 'Dr. Andru','Dr. Ridwan'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  Widget _buildInputField({
    required String label,
    required Widget inputWidget,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: inputWidget,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambahkan Antrian',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 23.0,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AntrianPage(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildInputField(
                label: 'Informasi Pasien',
                inputWidget: TextFormField(
                  controller: _patientInfoController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap masukkan informasi pasien';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              _buildInputField(
                label: 'Pilih Dokter',
                inputWidget: DropdownButtonFormField<String>(
                  value: _selectedDoctor,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedDoctor = newValue;
                    });
                  },
                  items: _doctorOptions.map((String doctor) {
                    return DropdownMenuItem<String>(
                      value: doctor,
                      child: Text(doctor),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap pilih dokter';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              // Tanggal Check Up - Input tanggal dengan kalender
              _buildInputField(
                label: 'Tanggal Check Up',
                inputWidget: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () {
                    _selectDate(context);
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Harap pilih tanggal check up';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Color(0xFF234DF0)),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Lakukan sesuatu dengan data yang diinputkan
                        // Misalnya, simpan data ke database atau lakukan tindakan lainnya
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Data submitted')),
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 18, 60, 243)),
                    ),
                    child: Text('Submit', style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}