import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/pages/Checkup/riwayat_checkup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hasil extends StatefulWidget {
  const Hasil({super.key});

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
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
          "Hasil",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Andru Falah Arifin", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
            Text("3122500048", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
            SizedBox(height: 15,),
            Text("Riwayat Check Up (5)", style: TextStyle(fontWeight: FontWeight.w600),),
                        SizedBox(height: 10,),
                        Flexible(child: ListView.builder(itemCount: 5, itemBuilder: (BuildContext context, int index){
                          return BoxRiwayat(onTapBox: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RiwayatCheckup()));
                          }, tanggal: "29/06/2024", nama: "Dr. Ian Ale Ale");
                        }))
          ],
        ),
      )),
    );
  }
}