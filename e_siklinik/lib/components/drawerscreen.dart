import 'package:e_siklinik/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  Future<bool> destroy() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          destroy();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Container(
            color: Colors.blue,
            child: const Text(
              "logout",
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
