import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';



class Checkup extends StatefulWidget {
  const Checkup({super.key});

  @override
  State<Checkup> createState() => _CheckupState();
}

class _CheckupState extends State<Checkup> {
  
  String? _doctors;
  List _mydoctor = [
    "Clara",
    "John",
    "Rizal",
    "Steve",
    "Laurel",
    "Bernard",
    "Miechel"
  ];
  String _medicineName = '';
  String _dosagePerDay = '';
  String _numberOfDays = '';
  List<String> _prescriptions = [];


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    void _addPrescription() {
    // Add prescription to the list
    if (_medicineName.isNotEmpty && _dosagePerDay.isNotEmpty && _numberOfDays.isNotEmpty) {
      setState(() {      
        _prescriptions.add('$_medicineName $_dosagePerDay X $_numberOfDays Hari');     
      });
    }
  }
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("CHECK UP",style: TextStyle(
          
        ),
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
                child: Icon(Icons.arrow_left,size: 50, color: Color.fromARGB(255, 0, 0, 0),),
              ),
            ],
          ),
        ),
      ),

      body: ListView(

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10.0,
                child: Container(  
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                
                                children: [                              
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text('Informasi Pasien',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'assets/fonts/Urbanist-VariableFont_wght.ttf',),),
                                  ),
                                  Row(
                                    
                                    children: [
                                      Text('NRP                    :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                Row(
                                    children: [
                                      Text('Nama                 :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Program studi   :',style: TextStyle(color: Colors.grey.shade700),)                                     
                                        ],
                                      ),                                           
                                    ],
                                  ),
                                SizedBox(height: 3,),
                                Row(
                                    children: [
                                      Text('Gender               :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                Row(
                                    children: [
                                      Text('Tanggal Lahir    :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                  Row(
                                    children: [
                                      Text('Alamat               :',style: TextStyle(color: Colors.grey.shade700),),
                                      
                                    ],
                                  ),
                                  
                                  SizedBox(height: 3,),
                                  Row(
                                    children: [
                                      Text('Nomor hp          :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                  Row(
                                    children: [
                                      Text('Nomor Wali       :',style: TextStyle(color: Colors.grey.shade700),)
                                    ],
                                  ),
                                  SizedBox(height: 3,),
                                ],
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        Row(
          children: [
            SizedBox(height: 20,)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Card(
            elevation: 10.0,
            child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(                                
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20,),
                          child: Text('Informasi Dokter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: 'Urbanist',),),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 310,
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromARGB(200, 235, 242, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10, top: 7, bottom: 7,right: 5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      icon: ImageIcon(AssetImage("assets/images/Vector.png")),
                                      decoration: InputDecoration.collapsed(hintText: ""),
                                      hint: Text("Pilih Nama Dokter",style: TextStyle(fontFamily: 'Urbanist',fontSize: 16, color: Colors.black),),
                                      value: _doctors,
                                      items: _mydoctor.map((value) {
                                      return DropdownMenuItem<String>(
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: BoxConstraints(minHeight: 48.0),
                                            child: Text(value, style: TextStyle(fontFamily: 'Urbanist',),
                                          ),
                
                                          ),
                                          
                                          value: value,
                
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          _doctors = value;  //Untuk memberitahu _valFriends bahwa isi nya akan diubah sesuai dengan value yang kita pilih
                                        });
                                      },
                                    ),
                                    
                                    ],
                                  ),
                                ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                   ))
                ],
              ),
            ),
          ),                  
        ],),
        Row(
          children: [
            SizedBox(height: 20,)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10.0,
              child: Container(
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hasil Check Up', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                    Row(
                      children: [
                        Text('Lorem ipsum dolor sit amet ')
                      ],
                    )
                  ],
                ),
              ),      
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(height: 20,)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 10.0,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  
                  color: Colors.white,
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5,left: 20),
                    child: Text('Resep Obat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Urbanist'),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10,left: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 260,
                          child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(200, 235, 242, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 9,bottom: 9, left: 20),
                            child: TextField(
                                onChanged: (value) {
                                  _medicineName = value;
                                },
                                decoration: InputDecoration.collapsed(                                      
                                filled: true,
                                fillColor: Color.fromARGB(200, 235, 242, 255),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: 'Nama Obat',
                                hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.normal, fontSize: 15)
                              ),
                            ),
                          ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: SizedBox(
                            width: 40,
                            height: 42,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromARGB(200, 235, 242, 255),
                              ),
                            child: IconButton(
                                onPressed: (){
                                   _addPrescription();
                                }, 
                                icon: Icon(Icons.add)
                              ), 
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10,bottom: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 130,
                              child: Container(
                                 decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromARGB(200, 235, 242, 255),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (value) {
                                    _dosagePerDay = value;
                                  },
                                      decoration: InputDecoration.collapsed(                                      
                                  filled: true,
                                  fillColor: Color.fromARGB(200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: 'Konsumsi Per Hari',
                                  hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.normal, fontSize: 12)
                                ),
                                  ),
                                ),
                              ),                               
                            ),
                            Icon(Icons.close_sharp),
                            SizedBox(
                              width: 105,
                              child: Container(
                                 decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromARGB(200, 235, 242, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    onChanged: (value) {
                                    _numberOfDays = value;
                                  },
                                  decoration: InputDecoration.collapsed(                                      
                                  filled: true,
                                  fillColor: Color.fromARGB(200, 235, 242, 255),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  hintText: 'Jumlah Hari',
                                  hintStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.normal, fontSize: 12)
                                ),
                                  ),
                                ),
                              ),                               
                            ),     
                          ],
                        ),
                      )                         
                    ],
                  ),
                  Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10, left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Daftar Resep Obat:'),    
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _prescriptions?.length ?? 0,
                                itemBuilder: (context, index) {
                                  final prescription = _prescriptions?[index];
                                  return ListTile(
                                    
                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                      title: Text('${index + 1}. $prescription'),
                                      
                                    );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                    
                ],
              ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(height: 10,)
          ],
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  
                },
                child: SizedBox(                
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            
                            color: Colors.white,
                          ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Text('Cancel', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  
                },
                child: SizedBox(                 
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            
                            color: Colors.blue,
                          ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
    );
  }
   
}