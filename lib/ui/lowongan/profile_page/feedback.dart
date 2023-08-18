import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: Icon(Icons.arrow_back_ios),
          ),
          margin: EdgeInsets.only(left: 15),
        ),
        centerTitle: true,
        title: Text(
          'Umpan Balik',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            SizedBox(height: 10),
            Text(
              'Nama',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Isi Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Email',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Isi Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Umpan Balik',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Kirim Saran atau Masukan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 45),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {},
              color: color.primary,
              child: Text(
                'Kirim Saran',
                style: TextStyle(
                  color: color.surface,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
