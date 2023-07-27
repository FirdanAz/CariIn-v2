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
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String selectedValue = "pria";
  String dateString = 'Pilih Tanggal';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const[
      DropdownMenuItem(child: Text("pria"), value: "pria"),
      DropdownMenuItem(child: Text("wanita"), value: "wanita"),
    ];
    return menuItems;
  }

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
          margin: const EdgeInsets.symmetric(
              horizontal: 20
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 70,),
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
              const SizedBox(height: 70,),
              Text(
                'Nama Pengguna',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary
                ),
              ),
              const SizedBox(height: 10,),
              TextFieldComp(emailController: _userNameController, hintText: 'Nama'),
              const SizedBox(height: 20,),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: color.primary
                ),
              ),
              const SizedBox(height: 10,),
              TextFieldComp(emailController: _emailController, hintText: 'Email'),
              const SizedBox(height: 20,),
              Text(
                'Password',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary
                ),
              ),
              const SizedBox(height: 10,),
              TextFieldComp(emailController: _passwordController, hintText: 'Password'),
              const SizedBox(height: 20,),
              Text(
                'Jenis Kelamin',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary
                ),
              ),
              Container(
                height: 50,
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    icon: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.arrow_drop_down)),
                    elevation: 18,
                    underline: Container(
                      height: 2,
                      color: color.black.withOpacity(0.1),
                    ),
                    style:
                    TextStyle(color: color.black),
                    iconSize: 30,
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        selectedValue = value!;
                      });
                    },
                  items: dropdownItems,

                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'Nomor Telepon',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary
                ),
              ),
              const SizedBox(height: 10,),
              TextFieldComp(emailController: _phoneNumberController, hintText: 'Nomor Telepon'),
              const SizedBox(height: 20,),
              Text(
                'Tanggal Lahir',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: color.primary
                ),
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:
                      DateTime.now(), //get today's date
                      firstDate: DateTime(
                          2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );

                  if(pickedDate!= null){
                    setState(() {
                      dateString = '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                    });
                  }
                },
                child: Container(
                  width: double.maxFinite,
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: color.primary, width: 2),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      dateString,
                      style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                    ),
                  ),
                ),
              ),
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
                  bool condition = await ApiService().postRegisterWorker(context, _emailController.text, _passwordController.text, _userNameController.text, selectedValue, _phoneNumberController.text, dateString);
                  await Future.delayed(const Duration(seconds: 1));
                  if(condition == true){
                    await Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(),), (route) => false);
                    Navigator.of(context).pop(true);
                  } else {
                    Navigator.of(context).pop(true);
                    print('isi form dengan lengkap dan benar');
                  }
                }, child: Center(child: Text('Daftar', style: TextStyle(color: color.white, fontWeight: FontWeight.w500, fontSize: 16),),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
