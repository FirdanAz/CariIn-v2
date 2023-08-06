import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
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
          'Akun CariIn',
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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Text(
                'Ubah Kata Sandi',
                style: TextStyle(
                  color: color.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                'Untuk melanjutkan verifikasi diri anda terlebih dahulu',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 75),
              TextField(
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: const TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: color.secondary.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Masukkan Kata Sandi',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
