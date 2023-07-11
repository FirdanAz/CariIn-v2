// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/login.dart';
import 'package:cariin_v2/ui/widget/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../service/api_service.dart';
import '../../karyawan/auth/register.dart';

class RegisterLowonganPage extends StatefulWidget {
  const RegisterLowonganPage({Key? key}) : super(key: key);

  @override
  State<RegisterLowonganPage> createState() => _RegisterLowonganPageState();
}

class _RegisterLowonganPageState extends State<RegisterLowonganPage> {
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
                'Daftar Untuk Mencari Lowongan',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              const SizedBox(height: 150,),
              TextFieldComp(emailController: _emailController, hintText: 'Email'),
              const SizedBox(height: 20,),
              TextFieldComp(emailController: _passwordController, hintText: 'Password'),
              const SizedBox(height: 20,),
              TextFieldComp(emailController: _emailController, hintText: 'Gender'),
              const SizedBox(height: 20,),
              TextFieldComp(emailController: _emailController, hintText: 'Phone Number'),
              const SizedBox(height: 20,),
              TextFieldComp(emailController: _emailController, hintText: 'Tanggal Lahir'),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(
                    top: 50
                ),
                child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginLowonganPage(),), (route) => false),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Sudah Punya Akun? ',
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
                  await ApiService().postLogin(context, _emailController.text, _passwordController.text, 'worker');
                  await Future.delayed(const Duration(seconds: 1));
                  if(await PublicFunction.getToken('worker') != ''){
                    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(),), (route) => false);
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
