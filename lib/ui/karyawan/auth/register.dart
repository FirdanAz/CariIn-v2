import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

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
  final _descriptionController = TextEditingController();
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

  final _numberToRoleMap = {
    0: 'pemilik',
    1: 'pengelola',
    2: 'HRD'
  };

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
              SizedBox(
                height: 70,
                width: double.maxFinite,
                child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedValue,
                    icon: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.arrow_drop_down)),
                    elevation: 18,
                    underline: Container(
                      height: 2,
                      width: 1,
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
                    items: bidangDropdownItems
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Didirikan',
                style: TextStyle(
                    fontSize: 18
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
              const SizedBox(height: 10,),
              const Text(
                'Sebagai',
                style: TextStyle(
                    fontSize: 18
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.maxFinite,
                child: GroupButton(
                  isRadio: false,
                  borderRadius: BorderRadius.circular(10),
                  spacing: 10,
                  buttonHeight: 60,
                  mainGroupAlignment: MainGroupAlignment.spaceEvenly,
                  selectedBorderColor: color.primary,
                  unselectedColor: color.primary,
                  selectedColor: color.white,
                  selectedTextStyle: TextStyle(
                      color: color.primary
                  ),
                  unselectedTextStyle: TextStyle(color: color.white),
                  buttons: const [
                    "Pemilik",
                    "Pengelola",
                    "HRD"
                  ],
                  selectedButtons: [
                    0
                  ],
                  onSelected: (int index, bool isSelected) {
                    if (kDebugMode) {
                      print('${_numberToRoleMap[index]} is selected');
                    }
                    setState(() {
                      selectedRole = index;
                    });
                  },

                ),
              ),
              SizedBox(height: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Deskripsi  ',
                    style: TextStyle(
                        fontSize: 18
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Container(
                    width: double.maxFinite,
                    constraints: BoxConstraints(minHeight: 130),
                    padding: const EdgeInsets.only(
                        left: 15,
                        right: 10
                    ),
                    decoration: BoxDecoration(
                        color: color.background,
                        borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 1, color: color.black.withOpacity(0.2))
                    ),
                    child: TextField(
                      controller: _descriptionController,
                      cursorColor: color.primary,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color.black
                      ),
                      decoration: InputDecoration(
                        hintText: "Seputar bisnis anda",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: color.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
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
                  if(_namaController.text != '' && _emailController.text != '' && _passwordController.text != '' && _descriptionController.text != ''){
                    showLoaderDialog(context);
                    await ApiService().postRegisterCompany(context, _emailController.text.toString(), _passwordController.text.toString(), _namaController.text.toString(), selectedValue, dateString, _numberToRoleMap[selectedRole].toString(), 'Indonesia', _descriptionController.text.toString());
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop(true);
                    if(PublicFunction.getToken('company') != ''){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(),), (route) => false);
                    }
                  }
                  else PublicFunction.showDialog(context, 'Isi Formulir dengan lengkap');
                }, child: Center(child: Text('Masuk', style: TextStyle(color: color.white, fontWeight: FontWeight.w500, fontSize: 16),),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
