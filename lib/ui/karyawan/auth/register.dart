// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/karyawan/auth/login.dart';
import 'package:cariin_v2/ui/karyawan/form/fill_data_company/fill_data.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';
import '../../../service/api_service.dart';

class CompanyRegisterPage extends StatefulWidget {
  const CompanyRegisterPage({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterPage> createState() => _CompanyRegisterPageState();
}

class _CompanyRegisterPageState extends State<CompanyRegisterPage> {
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String selectedValue = "Teknologi";
  String dateString = 'Pilih Tanggal';
  int selectedRole = 0;

  List<DropdownMenuItem<String>> get bidangDropdownItems {
    List<DropdownMenuItem<String>> menuItems = const[
      DropdownMenuItem(value: "Teknologi", child: Text("Teknologi")),
      DropdownMenuItem(value: "Pendidikan", child: Text("Pendidikan")),
      DropdownMenuItem(value: "Ekonomi", child: Text("Ekonomi")),
      DropdownMenuItem(value: "Seni dan Sastra", child: Text("Seni dan Sastra")),
      DropdownMenuItem(value: "Teknik dan Industri", child: Text("Teknik dan Industri")),
      DropdownMenuItem(value: "Kesehatan", child: Text("Kesehatan")),
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
            horizontal: 20,
            vertical: 50
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Daftar',
                style: TextStyle(
                    color: color.primary,
                    fontSize: 40,
                    fontWeight: FontWeight.w700
                ),
              ),
              const Text(
                'Memulai aplikasi',
                style: TextStyle(
                    fontSize: 16
                ),
              ),
              const SizedBox(height: 50,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nama perusahaan',
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _namaController,
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
                      hintText: 'Nama Perusahaan / Usaha',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
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
                ],
              ),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextField(
                    controller: _passwordController,
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
                      hintText: 'Password',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bidang Perusahaan',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    height: 70,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    decoration: BoxDecoration(
                      color: color.background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: color.black.withOpacity(0.2), width: 2)
                    ),
                    child: DropdownButton<String>(
                        isExpanded: true,
                        value: selectedValue,
                        icon: Container(
                          alignment: Alignment.centerLeft,
                          child: const Icon(Icons.arrow_drop_down),
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
                        items: bidangDropdownItems
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () => PublicFunction.navigatorPushAndRemoved(context, const LoginKaryawanPage()),
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 50
                  ),
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
                        'Masuk',
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
                  if(_namaController.text.isNotEmpty && _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty){
                    showLoaderDialog(context);
                    await ApiService().postRegisterCompany(context, _emailController.text, _passwordController.text, _namaController.text, selectedValue);
                    Navigator.of(context).pop(true);
                    if(PublicFunction.getToken('company') != ''){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const FillDataCompany(),), (route) => false);
                    }
                    showDialog(context: context, builder: (context) {
                      return PublicFunction.showDialog(context, 'Daftar sukses, Lanjutkan pengisian data perusahaan');
                    },);
                  }
                  else {
                    showDialog(context: context, builder: (context) {
                      return PublicFunction.showDialog(context, 'Isi Formulir dengan lengkap');
                    },);
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
