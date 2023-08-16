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
import 'package:pdf/widgets.dart' as pw;

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
    final pdf = pw.Document(compress: false);
    var data = await rootBundle.load("assets/fonts/outfit/Outfit-Regular.ttf");
    var myFont = pw.Font.ttf(data);
    //var myStyle = pw.TextStyle(font: myFont, fontSize: 20);
    final netImage = await imageFromAssetBundle(AppAssets.firdanImg);
    final pw.PageTheme pageTheme = pw.PageTheme(
      buildBackground: (pw.Context context) =>
          pw.Container(color: PdfColors.blue800),
    );

    pdf.addPage(
      pw.Page(
          pageTheme: pageTheme,
          build: (pw.Context context) => pw.Container(
              padding: const pw.EdgeInsets.all(20),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.all(20),
                      height: 650,
                      width: double.maxFinite,
                      decoration: const pw.BoxDecoration(
                          borderRadius: pw.BorderRadius.only(
                            bottomRight: pw.Radius.circular(50),
                          ),
                          color: PdfColors.white),
                      child: pw.SizedBox(
                          child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                            pw.Row(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.start,
                                children: [
                                  pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                      mainAxisAlignment: pw.MainAxisAlignment.start,
                                      children: [
                                    pw.Container(
                                        width: 100,
                                        height: 150,
                                        alignment: pw.Alignment.center,
                                        decoration: pw.BoxDecoration(
                                            color: PdfColors.white,
                                            borderRadius:
                                                pw.BorderRadius.circular(100)),
                                        child: pw.Image(netImage,
                                            fit: pw.BoxFit.cover)),
                                    pw.SizedBox(height: 20),
                                    pw.Text(userName,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                            font: myFont,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 18)),
                                    pw.Text(field,
                                        textAlign: pw.TextAlign.center,
                                        style: pw.TextStyle(
                                            font: myFont,
                                            fontWeight: pw.FontWeight.bold,
                                            fontSize: 16,
                                            color: PdfColors.blue900)),
                                  ]),
                                  pw.SizedBox(width: 30),
                                  pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.Text('Data Pribadi', style: pw.TextStyle(font: myFont, fontSize: 17)),
                                      pw.Row(
                                        mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                        children: [
                                          pw.Divider(),
                                          pw.Text('  Tempat, Tanggal lahir', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          pw.Text(' $bornDate', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                        ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Alamat', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' $address', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Nomor Telephone', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' $phoneNumber', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Agama', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' Islam', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Kewarga Negaraan', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' Indonesia', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Email', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' $email', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Jenis Kelamin', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' : ', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                            pw.Text(' $gender', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.SizedBox(height: 20),
                                      pw.Text('Pengalaman', style: pw.TextStyle(font: myFont, fontSize: 17)),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          children: [
                                            pw.Divider(),
                                            pw.Text('  Membantu mengembangkan flutter', style: pw.TextStyle(font: myFont, fontSize: 11)),
                                          ]
                                      ),
                                      pw.Row(
                                          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                                          children: [
                                            pw.Divider(),
                                            pw.SizedBox(width: 250, child: pw.Text('  Membuat design/ui aplikasi dengan sangat menarik', overflow: pw.TextOverflow.clip, style: pw.TextStyle(font: myFont, fontSize: 11)),)
                                          ]
                                      ),
                                    ]
                                  )
                                ])
                          ])),
                    )
                  ]))),
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

  static Future compressImage(File originalImage, int quality) async {
    String compressedImagePath = '/storage/emulated/0/Download/';
    String date = '${DateTime.now().day}${DateTime.now().month}${DateTime.now().year}${DateTime.now().second}';

    final file = await FlutterImageCompress.compressAndGetFile(
        originalImage.path,
        '$compressedImagePath/Cariin_$date.jpg',
        quality: quality
    );

    return File(file!.path);
  }
}
