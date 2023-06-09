import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AturCvPage extends StatefulWidget {
  const AturCvPage({super.key});

  @override
  State<AturCvPage> createState() => _AturCvPageState();
}

class _AturCvPageState extends State<AturCvPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 10),
        child: Text(
          'Atur CV',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
        ),
      ),
    );
  }
}
