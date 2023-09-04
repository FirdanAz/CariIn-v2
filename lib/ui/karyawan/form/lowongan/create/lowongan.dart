// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/karyawan/form/lowongan/create/fill_lowongan.dart';
import 'package:cariin_v2/ui/widget/auth_text_field.dart';
import 'package:flutter/material.dart';

import '../../../../../common/app_color.dart';

class CreateLowongan extends StatefulWidget {
  const CreateLowongan({Key? key}) : super(key: key);

  @override
  State<CreateLowongan> createState() => _CreateLowonganState();
}

class _CreateLowonganState extends State<CreateLowongan> {
  List<DropdownMenuItem<String>> timeType = getTimeTypeDropdownItems;
  List<DropdownMenuItem<String>> gender = getGenderDropdownItems;
  List<DropdownMenuItem<String>> education = getEducationDropdownItems;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String selectedTimeType = 'full time';
  String selectedGender = 'bebas';
  String selectedEducation = 'bebas';

  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _workerAvailableController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        title: const Text(
          'Buat Lowongan',
          style: TextStyle(fontSize: 17),
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _textField(
                        _titleController,
                        'Cth : Karyawan Indomaret',
                        TextInputType.text,
                        'Nama Lowongan',
                        'Hindari kata-kata yang dapat menyinggung Pelamar, Seperti kekerasan, Rasisme dan lain-lain'),
                    _textField(
                        _locationController,
                        'Cth : Kudus, Jawa Tengah, Indonesia',
                        TextInputType.text,
                        'Lokasi Lowongan',
                        'Isikan lokasi yang sesuai, untuk mempermudah Pelamar dalam memilih Lowongan'),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tipe Waktu',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: color.primary),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _subtitleText('Pilih Tipe Waktu yang dibutuhkan. Full Time untuk sepenuh waktu, dan Part Time untuk waktu yang lebih Sedikit', 14, 0.5),
                        SizedBox(
                          height: 70,
                          width: double.maxFinite,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedTimeType,
                            icon: Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.arrow_drop_down)),
                            elevation: 18,
                            underline: Container(
                              height: 2,
                              width: 1,
                              color: color.black.withOpacity(0.1),
                            ),
                            style: TextStyle(color: color.black),
                            iconSize: 30,
                            onChanged: (value) {
                              setState(() {
                                selectedTimeType = value!;
                              });
                            },
                            items: timeType,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Kelamin',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: color.primary),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _subtitleText('Jenis kelamin yang dibutuhkan perusahaan, pilih "Pria/Wanita" untuk tidak memberikan batas', 14, 0.5),
                        SizedBox(
                          height: 70,
                          width: double.maxFinite,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedGender,
                            icon: Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.arrow_drop_down)),
                            elevation: 18,
                            underline: Container(
                              height: 2,
                              width: 1,
                              color: color.black.withOpacity(0.1),
                            ),
                            style: TextStyle(color: color.black),
                            iconSize: 30,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value!;
                              });
                            },
                            items: gender,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pendidikan',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: color.primary),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        _subtitleText('Pilih Opsi Pendidikan sebagai minimal syarat Pelamar untuk melamar dipekerjaan ini', 14, 0.5),
                        SizedBox(
                          height: 70,
                          width: double.maxFinite,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedEducation,
                            icon: Container(
                                alignment: Alignment.centerRight,
                                child: const Icon(Icons.arrow_drop_down)),
                            elevation: 18,
                            underline: Container(
                              height: 2,
                              width: 1,
                              color: color.black.withOpacity(0.1),
                            ),
                            style: TextStyle(color: color.black),
                            iconSize: 30,
                            onChanged: (value) {
                              setState(() {
                                selectedEducation = value!;
                              });
                            },
                            items: education,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _textField(
                        _workerAvailableController,
                        '0',
                        TextInputType.number,
                        'Karyawan Dibutuhkan',
                        'Isi sesuai Karyawan yang dibutuhkan Min 1')
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              _nextButton(),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
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

  Widget _nextButton() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return SizedBox(
      width: double.maxFinite,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if(int.parse(_workerAvailableController.text) > 100){
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Karyawan Dibutuhkan Maximal 100 ;)'),);
            } else {
              showLoaderDialog(context);
              await Future.delayed(const Duration(seconds: 1));
              Navigator.of(context).pop();
              PublicFunction.navigatorPush(
                  context,
                  FillLowongan(
                      title: _titleController.text,
                      location: _locationController.text,
                      timeType: selectedTimeType,
                      gender: selectedGender,
                      education: selectedEducation,
                      workerAvailable: _workerAvailableController.text
                  )
              );
            }
          }
        },
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
            backgroundColor: MaterialStatePropertyAll(color.primary)),
        child: Text(
          'Lanjutkan',
          style: TextStyle(color: color.white),
        ),
      ),
    );
  }

  Widget _textField(TextEditingController controller, String hintText,
      TextInputType inputType, String title, String subtitle) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: color.primary),
        ),
        const SizedBox(
          height: 5,
        ),
        subtitle != '' ? _subtitleText(subtitle, 14, 0.5) : Container(),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          autocorrect: true,
          validator: (value) => PublicFunction.validateInput(value.toString()),
          controller: controller,
          textAlign: TextAlign.left,
          style: const TextStyle(color: Colors.black),
          keyboardType: inputType,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintStyle: const TextStyle(color: Colors.black45),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: color.secondary.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _subtitleText(String subtitle, double fontSize, double opacity) {
    return Text(
      subtitle,
      textAlign: TextAlign.justify,
      style: TextStyle(
          fontSize: fontSize, color: Colors.black.withOpacity(opacity)),
    );
  }
  // Widget _dropDown(String selectedValue, List<DropdownMenuItem<String>> dropDownItems, String title, String subTitle) {
  //   var color = AppColor.theme(Theme.of(context).brightness);
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(
  //             fontSize: 16,
  //             fontWeight: FontWeight.w600,
  //             color: color.primary),
  //       ),
  //       const SizedBox(
  //         height: 5,
  //       ),
  //       subTitle != '' ? _subtitleText(subTitle, 14, 0.5) : Container(),
  //       SizedBox(
  //         height: 70,
  //         width: double.maxFinite,
  //         child: DropdownButton<String>(
  //             isExpanded: true,
  //             value: selectedValue,
  //             icon: Container(
  //                 alignment: Alignment.centerRight,
  //                 child: const Icon(Icons.arrow_drop_down)),
  //             elevation: 18,
  //             underline: Container(
  //               height: 2,
  //               width: 1,
  //               color: color.black.withOpacity(0.1),
  //             ),
  //             style: TextStyle(color: color.black),
  //             iconSize: 30,
  //             onChanged: (value) {
  //               setState(() {
  //                 selectedValue = value!;
  //               });
  //             },
  //             items: dropDownItems,
  //
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

List<DropdownMenuItem<String>> get getTimeTypeDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "full time", child: Text("Full time")),
    DropdownMenuItem(value: "part time", child: Text("Part time")),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get getGenderDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(value: "bebas", child: Text("Pria/Wanita")),
    DropdownMenuItem(value: "pria", child: Text("Pria")),
    DropdownMenuItem(value: "wanita", child: Text("Wanita"))
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get getEducationDropdownItems {
  List<DropdownMenuItem<String>> menuItems = const [
    DropdownMenuItem(
        value: "smp", child: Text("Sekolah Menengah Pertama(SMP)")),
    DropdownMenuItem(value: "sma", child: Text("Sekolah Menengah Atas(SMA)")),
    DropdownMenuItem(
        value: "smk", child: Text("Sekolah Menengah Kejuruan(SMK)")),
    DropdownMenuItem(value: "bebas", child: Text("Bebas")),
  ];
  return menuItems;
}
