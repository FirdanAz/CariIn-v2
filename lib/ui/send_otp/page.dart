import 'package:cariin_v2/common/public_function.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';

import '../lowongan/auth_page/fill_data_worker.dart';

class InputOtpPage extends StatefulWidget {
  InputOtpPage({Key? key, required this.email, required this.password}) : super(key: key);
  String email;
  String password;

  @override
  State<InputOtpPage> createState() => _InputOtpPageState();
}

class _InputOtpPageState extends State<InputOtpPage> {
  final TextEditingController otpController = TextEditingController();
  EmailOTP myauth = EmailOTP();

  sendOtp() async {
    myauth.setConfig(
        appEmail: "cariin@dev.com",
        appName: "Email OTP",
        userEmail: widget.email,
        otpLength: 6,
        otpType: OTPType.digitsOnly
    );
    if(myauth.sendOTP() == true){
      showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Otp Telah Dikirimkan cek email anda'),);
    } else {
      showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Ups, Ada kesalahan'),);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sendOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Masukkan Kode OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Kami telah mengirimkan kode OTP ke email Anda.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Kode OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Validasi dan proses kode OTP
                String enteredOTP = otpController.text;
                if (myauth.verifyOTP(otp: otpController.text)) {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FillDataWorker(),), (route) => false);
                  _showSuccessDialog();
                } else {
                  _showErrorDialog('Kode OTP tidak valid.');
                }
              },
              child: Text('Verifikasi OTP'),
            ),
          ],
        ),
      ),
    );
  }

  bool isValidOTP(String otp) {
    // Implementasikan logika validasi kode OTP sesuai kebutuhan Anda
    // Contoh: Kode OTP harus memiliki panjang 6 karakter
    return otp.length == 6;
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifikasi Berhasil'),
          content: Text('Kode OTP yang Anda masukkan adalah valid.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup AlertDialog
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verifikasi Gagal'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup AlertDialog
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}