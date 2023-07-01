// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AppBarTitleRow extends StatelessWidget {
  final String title1;
  final String title2;
  const AppBarTitleRow({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title1,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        Text(
          " $title2",
          style: const TextStyle(
            color: Color.fromARGB(255, 247, 112, 34),
            fontSize: 23,
          ),
        )
      ],
    );
  }
}
