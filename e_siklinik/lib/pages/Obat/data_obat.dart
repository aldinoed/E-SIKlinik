import 'package:e_siklinik/pages/Obat/add_obat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataObat extends StatefulWidget {
  const DataObat({Key? key}) : super(key: key);

  @override
  State<DataObat> createState() => _DataObatState();
}

class _DataObatState extends State<DataObat> {
  String query = '';
  TextEditingController _searchController = TextEditingController();

  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    'Honeydew',
    'Kiwi',
    'Lemon',
  ];

  List<String> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = data;
  }

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
      filteredData = data.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text(
          "Database Obat",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_left,size: 50, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _searchController,
                onChanged: onQueryChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(200, 235, 242, 255),
                  labelText: 'Cari Obat',
                  labelStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 2.5),
              ),
              itemCount: filteredData.length,
              itemBuilder: (BuildContext context, int index) {
                return IntrinsicHeight(
                  child: Card(
                    elevation: 3,                 
                    child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.transparent,
                              child: Image.asset(
                                  'assets/images/obat.png',
                                  width: 40,
                                  height: 40,
                                  fit:BoxFit.fill,
                              ),
                            ),
                            trailing: SizedBox(
                              child: IconButton(
                                onPressed: (){},
                                icon: Icon(Icons.more_vert),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(filteredData[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                Text('EXP: '),
                                Text('Stok')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: CircleBorder(),
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) => AddObat())));
        },
        child: Icon(Icons.add, size: 40,color: Colors.white,),
      ),
    );
  }
}
