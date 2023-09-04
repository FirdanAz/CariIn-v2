import 'package:flutter/material.dart';

class SyaratKetentuanPage extends StatefulWidget {
  @override
  _SyaratKetentuanPageState createState() => _SyaratKetentuanPageState();
}

class _SyaratKetentuanPageState extends State<SyaratKetentuanPage> {
  bool _isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Syarat dan Ketentuan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Syarat dan Ketentuan',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  // Tambahkan teks syarat dan ketentuan yang lebih panjang di sini.
                  '1. Penggunaan Aplikasi\n\nPenggunaan aplikasi ini tunduk pada persetujuan Anda untuk mematuhi semua syarat dan ketentuan yang tercantum di sini. Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: <Widget>[
                Checkbox(
                  value: _isAccepted,
                  onChanged: (value) {
                    setState(() {
                      _isAccepted = value!;
                    });
                  },
                ),
                Text(
                  'Saya Setuju dengan Syarat dan Ketentuan',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isAccepted
                  ? () {
                // Aksi yang diambil jika pengguna menyetujui syarat dan ketentuan.
                Navigator.pop(context); // Kembali ke halaman sebelumnya atau ke halaman utama.
              }
                  : null,
              child: Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}