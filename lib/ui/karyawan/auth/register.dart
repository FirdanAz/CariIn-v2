import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../service/api_service.dart';
import '../../bottom_navigation/bottom_navigation_karyawan.dart';

class CompanyRegisterPage extends StatefulWidget {
  const CompanyRegisterPage({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterPage> createState() => _CompanyRegisterPageState();
}

class _CompanyRegisterPageState extends State<CompanyRegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    showLoaderDialog(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(backgroundColor: color.secondary),
            SizedBox(width: 14),
            const Text("Loading..."),
          ],
        ),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Haii!!',
                style: TextStyle(
                    color: color.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w700
                ),
              ),
              Text(
                'Login Untuk Memulai aplikasi',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              SizedBox(height: 150,),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: color.secondary.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(color: Colors.black45),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: color.secondary.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Password',
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.symmetric(
                    vertical: 5
                ),
                child: Text(
                  'Lupa Password',
                  style: TextStyle(
                    color: color.primary.withOpacity(0.8),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 50
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum Punya Akun? ',
                      style: TextStyle(
                          fontSize: 15
                      ),
                    ),
                    Text(
                      'Daftar',
                      style: TextStyle(
                          color: color.primary,
                          fontSize: 15,
                          fontWeight: FontWeight.w500
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 50
                ),
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: InkWell(onTap: () async {
                  //ApiService().postRegisterCompany(context, 'Kjomsul', 'komsul@gmail.com', '123123dsd', 'Teknologi', '2006-03-15', 'HRD', 'Indonesia', 'Google LLC adalah sebuah perusahaan multinasional Amerika Serikat yang berkekhususan pada jasa dan produk Internet.');
                }, child: Center(child: Text('Masuk', style: TextStyle(color: color.white, fontWeight: FontWeight.w500, fontSize: 16),),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
