import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/material.dart';

import '../../../common/app_assets.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  String selectedValue = "Pria";

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(child: Text("Pria"), value: "Pria"),
      DropdownMenuItem(child: Text("Wanita"), value: "Wanita"),
    ];
    return menuItems;
  }

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
          'Edit Profil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 17, right: 15),
        child: ListView(
          children: [
            Text(
              'Ubah Foto Profil',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: 130,
                height: 200,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                  child: Image.asset(
                    AppAssets.firdanImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            Text(
              'Ubah Nama',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nama Baru',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Atur Alamat',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Jl. Kudus',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: color.outline),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Jenis Kelamin',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            Container(
              height: 50,
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedValue,
                icon: Container(
                    alignment: Alignment.centerRight,
                    child: const Icon(Icons.arrow_drop_down)),
                elevation: 18,
                underline: Container(
                  height: 2,
                  color: color.black.withOpacity(0.1),
                ),
                style: TextStyle(color: color.black),
                iconSize: 30,
                onChanged: (String? value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                items: dropdownItems,
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Nomor Telepon',
              style: TextStyle(
                fontSize: 17,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Nomor Telepon',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: color.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {},
              color: color.primary,
              child: Text(
                'Simpan Perubahan',
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
