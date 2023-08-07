import 'package:cariin_v2/model/profil_company_model.dart';
import 'package:cariin_v2/ui/options/options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common/app_color.dart';
import '../../../common/public_function.dart';
import '../../../service/api_service.dart';

class ProfilCompanyPage extends StatefulWidget {
  const ProfilCompanyPage({Key? key}) : super(key: key);

  @override
  State<ProfilCompanyPage> createState() => _ProfilCompanyPageState();
}

class _ProfilCompanyPageState extends State<ProfilCompanyPage> {
  bool _isLoad = false;
  ProfilCompanyModel? profilCompanyModel;

  void _logOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "Ingin keluar dari akun ini ?",
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("No")),
            TextButton(
                onPressed: () async => await PublicFunction.removeToken('token')
                    .then((value) => PublicFunction.navigatorPushAndRemoved(
                        context, const OptionsPage())),
                child: const Text("Yes", style: TextStyle(color: Colors.red))),
          ],
        );
      },
    );
  }

  getdata() async {
    _isLoad = true;
    ProfilCompanyModel profilCompany = await ApiService().ProfilCompany();
    setState(() {
      profilCompanyModel = profilCompany;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return _isLoad
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor:
                          color.onPrimaryContainer.withOpacity(0.3)),
                  floating: true,
                  title: Text(
                    'Pengaturan Profil',
                    style: TextStyle(color: color.white, fontSize: 17),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                          onTap: () {
                            _logOut();
                          },
                          child: CircleAvatar(
                            child: Icon(
                              Icons.logout,
                              color: color.white,
                            ),
                            backgroundColor:
                                color.primaryContainer.withOpacity(0.2),
                          )),
                    )
                  ],
                  leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: color.white,
                    ),
                  ),
                  flexibleSpace: Stack(
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.network(
                          'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        color: color.black.withOpacity(0.4),
                      ),
                      Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        padding: EdgeInsets.only(top: 90),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  'https://cariin.my.id/storage/${profilCompanyModel!.data!.profileImage}'),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              profilCompanyModel!.data!.name.toString(),
                              style: TextStyle(
                                  color: color.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tagline bisnis',
                                  style: TextStyle(
                                    color: color.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Icon(
                                  Icons.edit_note,
                                  color: color.white,
                                  size: 18,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: color.white,
                                  size: 18,
                                ),
                                Text(
                                  profilCompanyModel!.data!.location.toString(),
                                  style: TextStyle(
                                    color: color.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(200),
                    child: Container(),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Container(
                          constraints:
                              BoxConstraints(minHeight: 60, maxHeight: 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.flag,
                                    color: profilCompanyModel!.data!.confirmedStatus == 'diterima' ? Colors.green : color.black,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                        color: profilCompanyModel!.data!.confirmedStatus == 'diterima' ? Colors.green : color.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  profilCompanyModel!.data!.confirmedStatus == 'diterima' ? Container(
                                    width: 200,
                                    child: const Text(
                                      'Terverifikasi',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ) : Container(
                                    width: 200,
                                    child: Text(
                                      'Belum Terverifikasi',
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: color.primary),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        _profileItems(
                            'Email',
                            profilCompanyModel!.data!.email.toString(),
                            Icons.email),
                        _profileItems(
                            'Alamat Lengkap',
                            profilCompanyModel!.data!.location.toString(),
                            Icons.location_on_rounded),
                        _profileItems(
                            'Deskripsi',
                            profilCompanyModel!.data!.description.toString(),
                            Icons.description),
                        _profileItems(
                            'Sejak',
                            profilCompanyModel!.data!.foundingDate.toString(),
                            Icons.date_range),
                        _profileItems(
                            'Sebagai',
                            profilCompanyModel!.data!.userType.toString(),
                            Icons.assignment_ind_rounded),
                        _profileItems(
                            'Peran',
                            profilCompanyModel!.data!.role.toString(),
                            Icons.supervised_user_circle),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foto tampak Luar',
                              style: TextStyle(
                                  color: color.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Foto akan ditampilkan setiap lowongan pekerja',
                              style: TextStyle(
                                color: color.black.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Image.network(
                                'https://cariin.my.id/storage/${profilCompanyModel!.data!.outsideImage}',
                                fit: BoxFit.cover,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Foto tampak Dalam',
                              style: TextStyle(
                                  color: color.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Foto akan ditampilkan setiap lowongan pekerja',
                              style: TextStyle(
                                color: color.black.withOpacity(0.6),
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              height: 100,
                              width: 100,
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: Image.network(
                                'https://cariin.my.id/storage/${profilCompanyModel!.data!.insideImage}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
  }

  Widget _profileItems(String title, String desc, IconData icon) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Container(
      constraints: BoxConstraints(minHeight: 60, maxHeight: 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: color.black,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                title,
                style:
                    TextStyle(color: color.black, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 200,
                child: Text(
                  desc,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: color.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
