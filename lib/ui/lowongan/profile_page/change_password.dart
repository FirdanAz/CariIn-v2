import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isVisible = false;
  bool _isPasswordEightCharacters = false;
  bool _hasPasswordOneNumber = false;

  onPasswordChanged(String password) {
    final numericRegex = RegExp(r'[0-9]');
    setState(() {
      _isPasswordEightCharacters = false;
      if (password.length >= 8) _isPasswordEightCharacters = true;

      _hasPasswordOneNumber = false;
      if (numericRegex.hasMatch(password)) _hasPasswordOneNumber = true;
    });
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kata Sandi',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: color.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Pilih Kata Sandi yang kuat dan jangan gunakan sandi dari situs lain atau sesuatu yang mudah ditebak.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (password) => onPasswordChanged(password),
              obscureText: !_isVisible,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: _isVisible
                      ? Icon(
                          Icons.visibility,
                          color: color.scrim,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: color.onSurfaceVariant,
                        ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: color.outline,
                  ),
                ),
                hintText: 'Kata Sandi Baru',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(microseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _isPasswordEightCharacters
                        ? Colors.green
                        : Colors.transparent,
                    border: _isPasswordEightCharacters
                        ? Border.all(color: Colors.transparent)
                        : Border.all(
                            color: color.outline,
                          ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(width: 10),
                Text('Berisi setidaknya 8 huruf'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: _hasPasswordOneNumber
                        ? Colors.green
                        : Colors.transparent,
                    border: _hasPasswordOneNumber
                        ? Border.all(color: Colors.transparent)
                        : Border.all(
                            color: color.outline,
                          ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                SizedBox(width: 10),
                Text('Berisi setidaknya 1 nomor'),
              ],
            ),
            SizedBox(height: 20),
            MaterialButton(
              height: 40,
              minWidth: double.infinity,
              onPressed: () {},
              color: color.primary,
              child: Text(
                'Ubah Sandi',
                style: TextStyle(
                  color: color.surface,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
