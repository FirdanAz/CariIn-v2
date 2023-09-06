import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/bottom_navigation/bottom_navigation.dart';
import 'package:cariin_v2/ui/lowongan/profile/setting.dart';
import 'package:cariin_v2/ui/view_image/view_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_assets.dart';
import '../../../common/app_color.dart';
import '../../../model/worker/worker_model.dart';
import '../../../model/worker/worker_profile_model.dart';
import '../../../service/api_service.dart';

class ProfileSolidPage extends StatefulWidget {
  const ProfileSolidPage({Key? key}) : super(key: key);

  @override
  State<ProfileSolidPage> createState() => _ProfileSolidPageState();
}

class _ProfileSolidPageState extends State<ProfileSolidPage> {
  ProfileWorkerModel? profileWorkerModel;
  WorkerModel? workerModels;
  bool _isLoad = false;
  bool allData = false;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    ProfileWorkerModel workerModel = await ApiService().getWorkerProfile();
    WorkerModel workerData = await ApiService().getWorker();
    setState(() {
      profileWorkerModel = workerModel;
      workerModels = workerData;
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

    return _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator()),) : Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya', style: TextStyle(fontSize: 20),),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingPage(),));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => CustomBottomNavigation(indexs: 3),), (route) => false);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: double.maxFinite,),
              CircleAvatar(
                backgroundColor: color.primaryContainer,
                radius: 65,
                child: CircleAvatar(
                  backgroundColor: color.primary,
                  radius: 60,
                  child: InkWell(
                    onTap: () => PublicFunction.navigatorPush(context, ViewImagePage(title: 'Foto Profi Saya', urlImage: 'https://cariin.my.id/storage/${profileWorkerModel!.data!.profileImage!}')),
                    child: CircleAvatar(
                      radius: 55,
                      backgroundImage: NetworkImage('https://cariin.my.id/storage/${profileWorkerModel!.data!.profileImage!}'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                workerModels!.data!.username!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                workerModels!.data!.email!,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'Data Pribadi',
                      style: TextStyle(
                        color: color.primary,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        _item(color.primaryContainer, color.primary, AppAssets.genderIcon, 'Jenis Kelamin', workerModels!.data!.gender!),
                        _item(Colors.purple.withOpacity(0.2), Colors.purple, AppAssets.TeknikIcon, 'Bidang', workerModels!.data!.interested!),
                        _item(Colors.red.withOpacity(0.2), Colors.red, AppAssets.contactIcon, 'Status Anda',  'Sedang ${workerModels!.data!.status!}'),
                        allData == true ? _item(Colors.yellow.withOpacity(0.2), Colors.orange, AppAssets.cakeIcon, 'Umur', '${workerModels!.data!.age!} Tahun') : Container(),
                        allData == true ? _item(Colors.deepOrangeAccent.withOpacity(0.2), Colors.deepOrangeAccent, AppAssets.contactIcon, 'Nomor Telepon', workerModels!.data!.phoneNumber!) : Container(),
                        allData == true ? _item(Colors.green.withOpacity(0.2), Colors.green, AppAssets.companyIcon, 'Alamat', workerModels!.data!.address!) : Container(),
                        const SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {
                            if(allData == false) {
                              setState(() {
                                allData = true;
                              });
                            } else {
                              setState(() {
                                allData = false;
                              });
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(color.primaryContainer),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                allData == false ? 'Lebih Banyak' : 'Lebih Sedikit',
                                style: TextStyle(
                                    color: color.primary,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Icon(allData == false ? Icons.arrow_downward : Icons.arrow_upward, color: color.primary, size: 17,)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'Pengalaman',
                      style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: workerModels!.data!.experiences!.length,
                          itemBuilder: (context, index) {
                            var data = workerModels!.data!.experiences![index];
                            return _experienceItem(workerModels!.data!.profilImage!, data.title!, data.description!);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      'Keahlian',
                      style: TextStyle(
                          color: color.primary,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: workerModels!.data!.skills!.length,
                          itemBuilder: (context, index) {
                            var data = workerModels!.data!.skills![index];
                            return _skillItem(data.name!);
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 50,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(Color color, Color iconColor,String svgImage, String title, String subTitle ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 63,
            width: 63,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(9.0),
                child: SvgPicture.asset(svgImage, fit: BoxFit.cover, color: iconColor,),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 15
                  ),
                ),
                Text(
                  subTitle,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _experienceItem(String img, String title, String subtitle) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return ListTile(
      leading: Image.asset(
        AppAssets.sliderImage,
        width: 80,
        height: 80,
        fit: BoxFit.fill,
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: color.primary),),
      subtitle: Text(subtitle, maxLines: 3,),
      // Tambahkan detail pengalaman atau aksi lainnya di sini
    );
  }

  Widget _skillItem(String title) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Container(
        decoration: BoxDecoration(
            color: color.primaryContainer,
            borderRadius: BorderRadius.circular(10)),
        width: double.maxFinite,
        height: 75,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      child: const Text(
                        'Sertifikasi',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                )
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Icon(Icons.workspace_premium_sharp, color: color.primary,),
                ),
              )
            ]
        )
    );
  }
}
