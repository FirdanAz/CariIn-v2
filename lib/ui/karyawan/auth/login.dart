import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/karyawan/auth/register.dart';
import 'package:cariin_v2/ui/karyawan/form/rincian_usaha/rincian_usaha.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../bottom_navigation/bottom_navigation_karyawan.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
                child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CompanyRegisterPage(),), (route) => false),
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
                  showLoaderDialog(context);
                  await Future.delayed(const Duration(seconds: 2));
                  await ApiService().postLogin(context, _emailController.text, _passwordController.text, 'company');
                  await Future.delayed(const Duration(seconds: 1));
                  if(await PublicFunction.getToken('company') != ''){
                    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(),), (route) => false);
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop(true);
                    print('isi form dengan lengkap');
                  }
                }, child: Center(child: Text('Masuk', style: TextStyle(color: color.white, fontWeight: FontWeight.w500, fontSize: 16),),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
