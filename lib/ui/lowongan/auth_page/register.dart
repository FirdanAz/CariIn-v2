// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/karyawan/form/fill_data_worker/fill_data.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/fill_data_worker.dart';
import 'package:cariin_v2/ui/lowongan/auth_page/login.dart';
import 'package:cariin_v2/ui/send_otp/page.dart';
import 'package:cariin_v2/ui/widget/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../service/api_service.dart';
import '../../../service/edit_service.dart';

class RegisterLowonganPage extends StatefulWidget {
  const RegisterLowonganPage({Key? key}) : super(key: key);

  @override
  State<RegisterLowonganPage> createState() => _RegisterLowonganPageState();
}

class _RegisterLowonganPageState extends State<RegisterLowonganPage> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obsText = true;
  String selectedOption = 'bekerja';
  List<DropdownMenuItem<String>> items = getItems;

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
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                'Daftar',
                style: TextStyle(
                    color: color.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              const Text(
                'Daftar Untuk Mencari Lowongan',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 70,
              ),
              Text(
                'Nama Pengguna',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldComp(
                  emailController: _userNameController, hintText: 'Nama', textInputType: TextInputType.text),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Email',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldComp(
                  emailController: _emailController, hintText: 'Email', textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Password',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.left,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.visiblePassword,
                obscureText: obsText,
                decoration: InputDecoration(
                  suffix: obsText ? InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        obsText = false;
                      });
                    },
                    child: Icon(Icons.remove_red_eye, color: color.primary,),
                  ) :
                  InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onTap: () {
                      setState(() {
                        obsText = true;
                      });
                    },
                    child: Icon(Icons.remove_red_eye_outlined, color: color.primary,),
                  ),
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Status Kerja',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary),
              ),
              const SizedBox(
                height: 10,
              ),
              _statusKerja(),

              Container(
                height: 50,
                width: double.maxFinite,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                decoration: BoxDecoration(
                    color: color.primary,
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                    onTap: () async {
                      showLoaderDialog(context);
                      await Future.delayed(const Duration(seconds: 2));
                      await DataService().editWorkerStatus(selectedOption);
                      bool condition = await ApiService().postRegisterWorker(
                          context,
                          _emailController.text,
                          _passwordController.text,
                          _userNameController.text);
                      await Future.delayed(const Duration(seconds: 1));
                      if (condition == true) {
                        await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InputOtpPage(email: _emailController.text, password: _passwordController.text),
                            ),
                            (route) => false);
                        Navigator.of(context).pop(true);
                      } else {
                        Navigator.of(context).pop(true);
                        print('isi form dengan lengkap dan benar');
                      }

                      // showLoaderDialog(context);
                      // await Future.delayed(Duration(seconds: 2));
                      // Navigator.of(context).pop();
                      // await ApiService().postLogin(context, 'gavra@gmail.com', 'password', 'worker');
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => const FillDataWorker(),));
                    },
                    child: Center(
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                            color: color.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusKerja() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey), // Warna border
            borderRadius: BorderRadius.circular(10), // Sudut border
          ),
          child: DropdownButtonFormField<String>(
            value: selectedOption,
            onChanged: (newValue) {
              setState(() {
                selectedOption = newValue!;
              });
            },
            items: items,
            decoration: InputDecoration(
              border: InputBorder.none, // Hapus border internal DropdownButtonFormField
            ),
          ),
        ),
      ],
    );
  }

}

List<DropdownMenuItem<String>> get getItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
        value: 'tidak_bekerja',
        child: Text("Sedang Tidak Bekerja", style: TextStyle(fontWeight: FontWeight.w400),)),
    DropdownMenuItem(
      value: "bekerja",
      child: Text(
        "Sedang Bekerja",
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    ),
  ];
  return menuItems;
}
