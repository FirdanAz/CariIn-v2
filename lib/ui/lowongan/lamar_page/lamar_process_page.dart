// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';

class LamarProcessPage extends StatefulWidget {
  LamarProcessPage({Key? key, required this.title, required this.jobId}) : super(key: key);
  String title;
  int jobId;

  @override
  State<LamarProcessPage> createState() => _LamarProccesPageState();
}

class _LamarProccesPageState extends State<LamarProcessPage> {
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        title: Row(
          children: [
            Text(
              'Lamar ',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: color.primary,
                fontSize: 18
              ),
            )
          ],
        ),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Persiapkan CV mu sebelum melamar!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: color.onSurface
              ),
            ),
            Text(
              'CV yang lengkap dapat membantu kamu menjadi kandidat ungguilan. Silahkan review CV mu dan lengkapi sekarang!',
              style: TextStyle(
                fontSize: 15,
                color: color.onSurface
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: double.maxFinite,
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 100),
                    decoration: BoxDecoration(
                      color: color.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: color.primaryContainer.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 4), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: SvgPicture.asset(
                            AppAssets.filterIcon,
                            // ignore: deprecated_member_use
                            color: color.primary,
                            height: 30,
                          ),
                        ),
                        Container(
                          width: 250,
                          margin: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Beberapa data anda masih kosong!',
                                  style: TextStyle(
                                      color: color.onPrimaryContainer,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15)),
                              Text(
                                  'Lengkapi data CV mu untuk melanjutkan lamaran perkerjaan.',
                                  style: TextStyle(
                                      color: color.onPrimaryContainer, fontSize: 13)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text('Perbarui Sekarang',
                                  style: TextStyle(
                                      color: color.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              width: double.maxFinite,
              constraints: BoxConstraints(minHeight: 130),
              padding: const EdgeInsets.only(
                  left: 15,
                  right: 10
              ),
              decoration: BoxDecoration(
                  color: color.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: TextField(
                cursorColor: color.primary,
                controller: _descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color.black
                ),
                decoration: const InputDecoration(
                  hintText: "Tuliskan alasan anda untuk melamar pekerjaan ini",
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: color.surfaceContainer,
        child: InkWell(
          onTap: () async {
            bool isSuccess = await ApiService().postWorkerJob(context, widget.jobId.toString(), _descriptionController.text);
            if(isSuccess == true){
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: const Text(
                    'Menunggu Konfirmasi dari perusahaan',
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CustomBottomNavigation(),), (route) => false),
                        child: const Text("Iya")),
                  ],
                );
              },);
            }else{
              showDialog(context: context, builder: (context) {
                return PublicFunction.showDialog(context, 'Anda telah melamar dilowongan ini');
              },);
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 50,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: color.primary,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Center(
              child: Text(
                'Lamar Pekerjaan',
                style: TextStyle(color: color.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
