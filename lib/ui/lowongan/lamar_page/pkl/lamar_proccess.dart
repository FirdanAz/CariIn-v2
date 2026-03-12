import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/lowongan/lamar_page/pkl/lamar_pkl.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class PklLamarPage extends StatefulWidget {
  PklLamarPage({Key? key, required this.jobId, required this.companyId}) : super(key: key);
  String jobId;
  String companyId;

  @override
  State<PklLamarPage> createState() => _PklLamarPageState();
}

class _PklLamarPageState extends State<PklLamarPage> {
  TextEditingController educationInstitution = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lamar Pkl',
          style: TextStyle(color: color.primary, fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios_new)),
        backgroundColor: color.background,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '     Praktik Kerja Lapangan atau PKL merupakan salah satu bentuk penyelenggaraan pendidikan dan pelatihan kejuruan. Kegiatan PKL juga banyak diikuti oleh mahasiswa dengan cara bekerja secara langsung di tengah lingkungan kerja dalam pelayanan masyarakat.',
                style: TextStyle(color: color.black, fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _customTextField(
                      educationInstitution, 'Asal Sekolah', 'Nama Sekolah Asal', 0, TextInputType.text),
                  const SizedBox(
                    height: 20,
                  ),
                  _customTextField(
                      descriptionController, 'Deskripsi', 'Deskripsi Lamaran', 200, TextInputType.text),
                ],
              ),
              Container(
                  height: 50,
                  margin: const EdgeInsets.only(top: 60),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(color.primary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      if(educationInstitution.text != '' && descriptionController.text != ''){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LamarPklPage(
                                educationInstitution: educationInstitution.text,
                                description: descriptionController.text,
                                jobId: widget.jobId,
                                companyId: widget.companyId,
                              ),
                            ));
                      } else {
                        showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Isi Form dengan lengkap'),);
                      }
                    },
                    child: Center(
                        child: Text(
                      'Lanjutkan',
                      style: TextStyle(color: color.white),
                    )),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField(TextEditingController editingController,
      String hintText, String title, double minHeight, TextInputType type) {
    final color = AppColor.theme(Theme.of(context).brightness);
    TextStyle textStyle = TextStyle(fontSize: 17, color: color.primary);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle,
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 15, right: 10),
          constraints: BoxConstraints(minHeight: minHeight),
          decoration: BoxDecoration(
              color: color.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: TextField(
            keyboardType: type,
            cursorColor: color.primary,
            controller: editingController,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: color.black),
            decoration: InputDecoration(
              hintText: hintText,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: color.black.withOpacity(0.7),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
