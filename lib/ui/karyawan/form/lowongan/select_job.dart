// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:cariin_v2/model/company/profil_company_model.dart';
import 'package:cariin_v2/service/firebase_api_service.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation_karyawan.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/company/job_company_model.dart';
import '../../../../service/api_service.dart';
import '../../../../service/edit_service.dart';
import '../../../widget/shimmer_widget.dart';
import 'create_lowongan.dart';

class SelectJob extends StatefulWidget {
  SelectJob({Key? key, required this.workerId}) : super(key: key);
  int workerId;

  @override
  State<SelectJob> createState() => _SelectJobState();
}

class _SelectJobState extends State<SelectJob> {
  bool _isLoad = false;
  JobCompanyModel? allJobCompany;
  String? deviceToken;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    JobCompanyModel allJob = await ApiService().jobsCompany(true, '');
    var token = await DataService().getWorkerDevice(widget.workerId.toString());
    setState(() {
      allJobCompany = allJob;
      deviceToken = token.toString();
    });
    if (kDebugMode) {
      print(allJob);
    }
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

    return Scaffold(
      appBar: AppBar(),
      body: _isLoad ? ShimmerJobCard(marginHorizon: 20,) : allJobCompany!.data!.isNotEmpty ?
      SingleChildScrollView(
        child: SizedBox(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: allJobCompany!.data!.length,
            itemBuilder: (context, index) {
              var job = allJobCompany!.data![index];
              DateTime? date = DateTime.parse(job.createdAt.toString());
              return InkWell(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Pilih ${job.title} untuk merekrut', style: const TextStyle(fontSize: 17),),
                      actions: [
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Batal'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            PublicFunction.navigatorPush(context, RecruitWorkerMain(jobId: job.id!, workerId: widget.workerId, deviceToken: deviceToken!, jobName: job.title!,));
                          },
                          child: Text('Pilih'),
                        )
                      ],
                    );
                  },);
                },
                child: Column(
                  children: [
                    Container(
                      height: 140,
                      width: double.maxFinite,
                      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: color.primary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset:
                            const Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              job.title.toString(),
                              style: TextStyle(
                                  color: color.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Pengalaman',
                                  style: TextStyle(
                                      color: color.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor:
                                  color.white.withOpacity(0.5),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '1 - 3 Tahun',
                                  style: TextStyle(
                                      color: color.white.withOpacity(0.6),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.secondaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Front End',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Ui/Ux Designer',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  margin: EdgeInsets.only(right: 7),
                                  decoration: BoxDecoration(
                                      color: color.primaryContainer,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Hacker',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 7, left: 2),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 4,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                        color: color.secondaryContainer
                                            .withOpacity(0.5),
                                        borderRadius:
                                        BorderRadius.circular(2)),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.company!.name.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: color.secondaryContainer
                                                .withOpacity(0.8)),
                                      ),
                                      Text(
                                        job.company!.location.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: color.secondaryContainer
                                                .withOpacity(0.8)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: double.maxFinite,
                      margin: EdgeInsets.only(left: 15, right: 15),
                      decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset:
                            Offset(2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(GetTimeAgo.parse(date, locale: 'id'),
                              style: TextStyle(
                                  color: color.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                          SizedBox(
                            width: 13,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ): Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: color.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(AppAssets.wIcon, width: 40,),
              ),
            ),
            const SizedBox(height: 25,),
            const Text(
              'Belum ada pelamar',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 50,),
            SizedBox(
              width: 200,
              child: Text(
                'Buat lowongan untuk mendapatkan Pelamar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 40
              ),
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateLowonganPage(),)),
                child: Container(
                  width: double.maxFinite,
                  height: 50,
                  decoration: BoxDecoration(color: color.primary,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      'Buat Lowongan',
                      style: TextStyle(
                          fontSize: 15,
                          color: color.white
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecruitWorkerMain extends StatefulWidget {
  RecruitWorkerMain({Key? key, required this.jobId, required this.workerId, required this.deviceToken, required this.jobName}) : super(key: key);
  int jobId;
  int workerId;
  String deviceToken;
  String jobName;

  @override
  State<RecruitWorkerMain> createState() => _RecruitWorkerMainState();
}

class _RecruitWorkerMainState extends State<RecruitWorkerMain> {
  final _descController = TextEditingController();
  ProfilCompanyModel? profilCompanyModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('company', await PublicFunction.getToken('company'));
    ProfilCompanyModel companyModel = await ApiService().ProfilCompany();
    setState(() {
       profilCompanyModel = companyModel;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator(),),) : Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        backgroundColor: color.background,
        title: Text(
          'Rekrut Karyawan',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: color.primary,
              fontSize: 18
          ),
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
            Container(
              margin: EdgeInsets.only(top: 20),
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
                controller: _descController,
                cursorColor: color.primary,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: color.black
                ),
                decoration: const InputDecoration(
                  hintText: "Tuliskan alasan anda untuk merekrut pekerja ini",
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
            bool isSuccess = await ApiService().createWorkerRecruit(context, widget.jobId.toString(), widget.workerId.toString(), _descController.text);
            if(isSuccess == true){
              await FirebaseApiService().firebaseSendNotif(widget.deviceToken, "Kamu direkrut perusahaan!!", "${profilCompanyModel!.data!.name} Baru saja mengundang anda di pekerjaan ${widget.jobName}", 'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}');
              await DataService().sendInbox(profilCompanyModel!.data!.id!.toString(), 'company', 'Kamu Mendapat Lamaran', "${profilCompanyModel!.data!.name} Baru saja mengundang anda di pekerjaan ${widget.jobName}");
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  content: const Text(
                    'Mengirim Undangan Sukses!',
                    style: TextStyle(fontSize: 15),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => KaryawanBottomNavigation(indexs: 1),), (route) => false),
                        child: const Text("Iya")),
                  ],
                );
              },);
            }else{
              showDialog(context: context, builder: (context) {
                return PublicFunction.showDialog(context, 'Anda telah Mengundang Pekerja ini');
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
                'Lanjutkan',
                style: TextStyle(color: color.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

