import 'package:e_siklinik/components/box.dart';
import 'package:e_siklinik/pages/Antrian/antrian.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Color(0xFFF9F9FB),

      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Color(0xFFD9D9D9),
                ),
                width: double.infinity,
                height: 150,
                child: const Center(
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: 160,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Jadwal Antrian",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Tampilkan Semua",
                              style: TextStyle(color: Colors.grey),
                            ))
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              offset: const Offset(-1, 2),
                              blurRadius: 3,
                              spreadRadius: 0,
                            ),
                          ],
                          image: const DecorationImage(
                              image: AssetImage('assets/images/Schedule.png'),
                              fit: BoxFit.fill)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Andru Falah Arifin",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "3122500038",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.timer_outlined,
                                color: Color(0xFF234DF0),
                                size: 18,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "13.00 - 13.30",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                "Utilities",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Column(
                children: [
                  Box(
                    title: 'Check Up',
                    desc: 'Tambahkan Hasil Check Up Pasien',
                    bgimage: 'assets/images/Utilities1.png',
                    icon: const Icon(
                      Icons.data_saver_on,
                      size: 25,
                      color: Color(0xFF234DF0),
                    ),
                    onTapBox: () {},
                  ),
                  Box(
                    title: 'Jadwal Antrean',
                    desc: 'Mengatur Jadwal Antrean Pasien',
                    bgimage: 'assets/images/Utilities2.png',
                    icon: const Icon(Icons.people_alt,
                        size: 25, color: Color(0xFF234DF0)),
                    onTapBox: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AntrianPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
