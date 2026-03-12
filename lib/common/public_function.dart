import 'dart:convert';
import 'dart:io';

import 'package:cariin_v2/common/app_assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

class PublicFunction {
  static Future<bool> setTokenCompany(String value, String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> token = {"role": role, "token": value};
    String encodedMap = json.encode(token);

    return prefs.setString("token", encodedMap);
  }

  static Future<String> getToken(String role) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("token") != null) {
      final dataToken = json.decode(prefs.getString('token').toString())
          as Map<String, dynamic>;

      if (kDebugMode) {
        print(dataToken);
      }

      if (dataToken['role'] == role) {
        var token = dataToken['token'];
        return token;
      } else {
        return '';
      }
    } else {
      return '';
    }
  }

  static Future<bool> removeToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(token);
  }

  static void navigatorPushAndRemoved(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (_) => widget), (route) => false);
  }

  static AlertDialog showDialog(BuildContext context, String massage) {
    return AlertDialog(
      content: Text(
        massage,
        style: const TextStyle(fontSize: 15),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Iya")),
      ],
    );
  }

  static void navigatorPushAndRemoveUntil(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, -0.1);
            const end = Offset.zero;
            const curve = Curves.fastOutSlowIn;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(position: offsetAnimation, child: child);
          },
          pageBuilder: (context, animation, secondaryAnimation) {
            return widget;
          },
        ),
        (route) => false);
  }

  static void navigatorPush(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.2, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return widget;
        },
      ),
    );
  }

  static Future<File> getPdf(
    int uId,
    String userName,
    String field,
    String bornDate,
    String address,
    String phoneNumber,
    String email,
    String gender,
  ) async {
    final pdf = pdfWidgets.Document(compress: false);
    var data = await rootBundle.load("assets/fonts/outfit/Outfit-Regular.ttf");
    var myFont = pdfWidgets.Font.ttf(data);
    //var myStyle = pw.TextStyle(font: myFont, fontSize: 20);
    final pdfWidgets.PageTheme pageTheme = pdfWidgets.PageTheme(
      buildBackground: (pdfWidgets.Context context) =>
          pdfWidgets.Container(color: PdfColors.amber700),
    );

    pdf.addPage(
      pdfWidgets.Page(
        build: (context) {
          return pdfWidgets.Column(
            crossAxisAlignment: pdfWidgets.CrossAxisAlignment.start,
            children: [
              pdfWidgets.Header(
                level: 0,
                text: 'Curriculum Vitae',
              ),
              pdfWidgets.SizedBox(height: 20),
              pdfWidgets.Text('Informasi Pribadi:'),
              pdfWidgets.Paragraph(
                text: 'Nama: $userName',
              ),
              pdfWidgets.Paragraph(
                text: 'Alamat: $address',
              ),
              pdfWidgets.Paragraph(
                text: 'Tanggal Lahir: $bornDate',
              ),
              pdfWidgets.Paragraph(
                text: 'Jenis Kelamin: $gender',
              ),
              pdfWidgets.Paragraph(
                text: 'Email: $email',
              ),
              pdfWidgets.Paragraph(
                text: 'Telepon: $phoneNumber',
              ),
              pdfWidgets.SizedBox(height: 20),
              pdfWidgets.Text('Pendidikan:'),
              pdfWidgets.Paragraph(
                text: 'Sarjana Teknik Informatika',
              ),
              pdfWidgets.Paragraph(
                text: 'Universitas Contoh',
              ),
              pdfWidgets.Paragraph(
                text: 'Tahun lulus: 2020',
              ),
              pdfWidgets.SizedBox(height: 20),
              pdfWidgets.Text('Pengalaman Kerja:'),
              pdfWidgets.Paragraph(
                text: field,
              ),
              pdfWidgets.Paragraph(
                text: 'Perusahaan Contoh',
              ),
              pdfWidgets.Paragraph(
                text: 'Tahun: 2020-2022',
              ),
              pdfWidgets.SizedBox(height: 20),
              pdfWidgets.Text('Keahlian:'),
              pdfWidgets.Bullet(
                text: 'Pengembangan Aplikasi Mobile (Flutter)',
              ),
              pdfWidgets.Bullet(
                text: 'Bahasa Pemrograman: Dart, Python, Java',
              ),
            ],
          );
        },
      ),
    ); // Page

    List<int> bytes = await pdf.save();

    final dir = (await getApplicationDocumentsDirectory());
    final file = File("${dir.path}/mycv$uId.pdf");

    await file.writeAsBytes(bytes, flush: true);

    if (kDebugMode) {
      print(file.path);
    }
    return file;
  }

  static Future compressImage(
      File originalImage, int quality, String title) async {
    Directory baseDir = await getTemporaryDirectory();
    // String newDirectoryName = 'Cariin';
    // Directory newDir = Directory('${baseDir.path}/$newDirectoryName');
    // if (await newDir.exists()) {
    //   print('Directory already exists.');
    //   return;
    // }
    // newDir.create();
    // print('New directory created: ${newDir.path}');
    String compressedImagePath = '/storage/emulated/0/Download/';
    String date =
        '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().second}';

    final file = await FlutterImageCompress.compressAndGetFile(
        originalImage.path, '$compressedImagePath/Cariin_${title}_$date.jpg',
        quality: quality);

    return File(file!.path);
  }

  static String? validateInput(String value) {
    if (value.isEmpty) {
      return 'Tidak boleh kosong!!';
    }
    return null; // Input is valid
  }

  static String? validateEmail(String value) {
    // Regular expression to validate email format
    String pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Masukkan Email Yang Valid';
    }
    return null; // Input is valid
  }

}
