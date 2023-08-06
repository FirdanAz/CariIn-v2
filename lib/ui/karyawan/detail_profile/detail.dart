// ignore_for_file: must_be_immutable, deprecated_member_use, non_constant_identifier_names

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/worker_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../service/api_service.dart';

class DetailProfil extends StatefulWidget {
  DetailProfil({Key? key, required this.id}) : super(key: key);
  int id;

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  bool _isLoad = false;
  WorkerDetailModel? workerDetailModel;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    WorkerDetailModel detail = await ApiService().getWorkerDetail(widget.id);
    setState(() {
      workerDetailModel = detail;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? const Center(child: CircularProgressIndicator(),) : Scaffold(
      backgroundColor: color.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
            title: Text(
              'Profil',
              style: TextStyle(
                  color: color.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              height: 140,
              margin: const EdgeInsets.symmetric(
                  horizontal: 13
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        right: 5
                    ),
                    child: const CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.firdanImg),
                      radius: 60,
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 120,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: const BorderRadius.all(Radius.circular(5))
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 10
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workerDetailModel!.data!.username!,
                                    style: TextStyle(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '${workerDetailModel!.data!.age} Tahun',
                                    style: TextStyle(
                                        color: color.black,
                                        fontSize: 14
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(child: SvgPicture.asset(AppAssets.cvIcon, width: 25,color: color.primary,), onTap: () {},)
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              workerDetailModel!.data!.address!,
                              style: TextStyle(
                                  color: color.black,
                                  fontSize: 14
                              ),
                            ),
                            Text(
                              ', Indonesia',
                              style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: const EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.primary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                workerDetailModel!.data!.interested!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: color.white
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: const EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.primary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Front End',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: color.white
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ProfilCard(context, AppAssets.genderIcon, 'Jenis Kelamin', workerDetailModel!.data!.gender!),
                ProfilCard(context, AppAssets.activityIcon, 'Aktivitas', ' - Belum Ada'),
                ProfilCard(context, AppAssets.fieldIcon, 'Bidang', workerDetailModel!.data!.interested!),
                ProfilCard(context, AppAssets.motivationIcon, 'Motivasi', 'Berhubungan dengan skil dan pengalaman kerja'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: color.white,
        child: InkWell(
          onTap: () {
            showDialog(context: context, builder: (context) {
              return PublicFunction.showDialog(context, 'Menuggu akun untuk diferifikasi 24x1 jam');
            },);
          },
          hoverColor: Colors.black,
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 18,
            margin: const EdgeInsets.symmetric(
                horizontal: 10
            ),
            decoration: BoxDecoration(
                color: color.primary,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Text(
              'Undang Wawancara',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget ProfilCard(BuildContext context, String image, String title, String desc) {
  var color = AppColor.theme(Theme.of(context).brightness);

  return Container(
    width: double.maxFinite,
    margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10
    ),
    child: Card(
      color: color.white,
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            margin: const EdgeInsets.only(
                left: 10,
                top: 20,
                right: 20,
                bottom: 40
            ),
            child: Stack(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: const BorderRadius.all(Radius.circular(10))
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: 25,
                      top: 25
                  ),
                  child: SvgPicture.asset(
                    image,
                    width: 25,
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: color.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 15
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: SizedBox(
                    width: 200,
                    child: Text(
                      desc,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          color: color.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}