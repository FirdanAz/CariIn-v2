// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/karyawan/auth/register.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../bottom_navigation/bottom_navigation_karyawan.dart';

class LoginKaryawanPage extends StatefulWidget {
  const LoginKaryawanPage({Key? key}) : super(key: key);

  @override
  State<LoginKaryawanPage> createState() => _LoginKaryawanPageState();
}

class _LoginKaryawanPageState extends State<LoginKaryawanPage> {
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
            const SizedBox(width: 14),
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
          margin: const EdgeInsets.symmetric(
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
              const Text(
                'Login Untuk Memulai aplikasi',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              const SizedBox(height: 150,),
              TextField(
                controller: _emailController,
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
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintStyle: const TextStyle(color: Colors.black45),
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
                margin: const EdgeInsets.symmetric(
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
                margin: const EdgeInsets.only(
                  top: 50
                ),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CompanyRegisterPage(),)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
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
                margin: const EdgeInsets.symmetric(
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
                    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 0,),), (route) => false);
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
