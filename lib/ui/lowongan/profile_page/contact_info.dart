import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({super.key});

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
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
          'Info Kontak',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              'Nomor Telepon',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                hintText: '08192879290',
                border: OutlineInputBorder(
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
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                enabled: false,
                hintText: 'Vitto2@gmail.com',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
