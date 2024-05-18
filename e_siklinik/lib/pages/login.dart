import 'package:e_siklinik/control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF234DF0),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            const Text(
                              "E-SiKlinik",
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFCFDFE),
                              ),
                            ),
                            const Text(
                              "Your Personal Babu",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFFCFDFE),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 400,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/logo.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return DraggableScrollableSheet(
                                expand: false,
                                builder: (BuildContext context, ScrollController scrollController) {
                                  return SingleChildScrollView(
                                    controller: scrollController,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Sign In",
                                            style: TextStyle(
                                              fontSize: 35,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF234DF0),
                                            ),
                                          ),
                                          const Text(
                                            "Selamat Datang Kembali",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF8B8D98),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 16),
                                            margin: const EdgeInsets.only(top: 50),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Username",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    color: Color(0xFFEBF2FF),
                                                  ),
                                                  child: TextFormField(
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  "Password",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                                  height: 50,
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                                    color: Color(0xFFEBF2FF),
                                                  ),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration: const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const ControlPage()));
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(top: 30, left: 16, right: 16),
                                              width: double.infinity,
                                              height: 50,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                                color: Color(0xFF234DF0),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Sign In",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFFCFCFD),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 50),
                          height: 50,
                          width: 250,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xFFFCFCFD),
                          ),
                          child: const Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF234DF0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
