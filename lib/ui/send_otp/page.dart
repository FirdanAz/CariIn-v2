import 'dart:math';

import 'package:cariin_v2/common/public_function.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../common/app_color.dart';
import '../lowongan/auth_page/fill_data_worker.dart';

class InputOtpPage extends StatefulWidget {
  InputOtpPage({Key? key, required this.email, required this.nextPage}) : super(key: key);
  String email;
  Widget nextPage;

  @override
  State<InputOtpPage> createState() => _InputOtpPageState();
}

class _InputOtpPageState extends State<InputOtpPage> {
  final OtpFieldController otpController = OtpFieldController();
  EmailOTP myauth = EmailOTP();

  sendOtp() async {
    myauth.setConfig(
        appEmail: "cariin@dev.com",
        appName: "Kode Verifikasi (Cariin)",
        userEmail: widget.email,
        otpLength: 4,
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
    var color = AppColor.theme(Theme.of(context).brightness);

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
              'Kami telah mengirimkan kode OTP ke email ${widget.email}.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 16.0),
            OTPTextField(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              style: TextStyle(
                  fontSize: 17,
                color: color.primary
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                bool success = myauth.verifyOTP(otp: pin);
                if(success == true){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget.nextPage,), (route) => false);
                  _showSuccessDialog();
                } else {
                  showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'masukkan OTP dengan benar'),);
                }
              },
            )
          ],
        ),
      ),
    );
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