import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String bgimage;
  final String title;
  final String desc;
  final String icon;
  final VoidCallback onTapBox;
  const Box({super.key, required this.title, required this.desc, required this.bgimage, required this.icon, required this.onTapBox});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTapBox,
          child: Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            height: 100,
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
                image: DecorationImage(
                    image: AssetImage(bgimage),
                    fit: BoxFit.fill)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 25,
                      height: 25,
                      margin: const EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(icon),
                              fit: BoxFit.fill)),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        desc,
                        style: const TextStyle(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 5,)
      ],
    );
  }
}
