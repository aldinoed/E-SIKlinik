import 'package:e_siklinik/pages/login.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Container(
          color: Colors.blue,
          child: const Text("logout", style: const TextStyle(color: Colors.white),)),
      ),
    );
  }
}