// import 'dart:convert';
// import 'package:e_siklinik/components/box.dart';
// import 'package:e_siklinik/pages/Checkup/riwayat_checkup.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Hasil extends StatefulWidget {
//   final int checkupId;
//   const Hasil({Key? key, required this.checkupId}) : super(key: key);

//   @override
//   State<Hasil> createState() => _HasilState();
// }

// class _HasilState extends State<Hasil> {
//   Map<String, dynamic>? checkupList;

//   @override
//   void initState() {
//     super.initState();
//     _getCheckup();
//   }

//   Future<void> _getCheckup() async {
//     try {
//       final response = await http.get(
//           Uri.parse("http://10.0.2.2:8000/api/checkup-result/show/${widget.checkupId}"));
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data != null && data['checkup'] != null) {
//           setState(() {
//             checkupList = data['checkup'];
//           });
//         }
//       } else {
//         print("Failed to load pasien");
//       }
//     } catch (error) {
//       print('Error : $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 2,
//         shadowColor: Colors.black,
//         centerTitle: true,
//         title: const Text(
//           "Hasil",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: checkupList != null
//           ? SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "${checkupList!['check_up_resul_to_assesmen']['assesmen_to_antrian']['antrian_to_pasien']['nama']}",
//                       style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
//                     ),
//                     const Text(
//                       "3122500048",
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
//                     ),
//                     const SizedBox(height: 15),
//                     const Text(
//                       "Riwayat Check Up (5)",
//                       style: TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 10),
//                     Flexible(
//                       child: ListView.builder(
//                         itemCount: 5,
//                         itemBuilder: (BuildContext context, int index) {
//                           return BoxRiwayat(
//                             onTapBox: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => const RiwayatCheckup()));
//                             },
//                             tanggal: "29/06/2024",
//                             nama: "Dr. Ian Ale Ale",
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Center(child: CircularProgressIndicator()),
//     );
//   }
// }import 'package:flutter/material.dart';

import 'package:e_siklinik/components/dropdown_search.dart';
import 'package:flutter/material.dart';

class AutocompleteDropDown extends StatefulWidget {
  const AutocompleteDropDown({Key? key}) : super(key: key);

  @override
  State<AutocompleteDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<AutocompleteDropDown> {
  String _selectedItem = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Container(
            width: 300,
            padding: const EdgeInsets.all(8.0),
            child: AutocompleteTextField(
              items: _countries,
              decoration: const InputDecoration(
                  labelText: 'Select country',
                  border: OutlineInputBorder()),
              validator: (val) {
                if (_countries.contains(val)) {
                  return null;
                } else {
                  return 'Invalid Country';
                }
              },
              onItemSelect: (selected) {
                setState(() {
                  _selectedItem = selected;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
/// list of countries
final List<String> _countries = [
  "Afghanistan",
  "Åland Islands",
  "Albania",
  "Algeria",
  "American Samoa",
  "Andorra",
];
