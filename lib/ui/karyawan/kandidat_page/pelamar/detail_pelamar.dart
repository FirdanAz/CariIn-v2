import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/model/detail_pelamar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/api_service.dart';

class DetailPelamarPage extends StatefulWidget {
  DetailPelamarPage({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<DetailPelamarPage> createState() => _DetailPelamarPageState();
}

class _DetailPelamarPageState extends State<DetailPelamarPage> {
  DetailPelamarModel? detailPelamarModel;
  bool _isLoad = false;

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    DetailPelamarModel detail = await ApiService().detailPelamar(widget.id);
    setState(() {
      detailPelamarModel = detail;
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

    return _isLoad ? const Scaffold(body: Center(child: CircularProgressIndicator(),),) : Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: color.primaryContainer),
            title: Text(
              'Detail Pelamar',
              style: TextStyle(
                  color: color.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w600
              ),
            ),
            actions: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: InkWell(
                     onTap: () async {
                       bool isSuccess = await ApiService().defineConfirmation(context, 'ditolak', '${detailPelamarModel!.data!.id}');
                       if(isSuccess == true){
                         setState(() {
                           getdata();
                         });
                         showDialog(context: context, builder: (context) {
                           return PublicFunction.showDialog(context, 'Lamaran Ditolak');
                         },);
                       }
                     },
                     child: Icon(detailPelamarModel!.data!.confirmedStatus == 'menunggu' ? Icons.folder_delete :null, color: color.error,size: 30,)),
               )
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.maxFinite,
              height: 140,
              margin: EdgeInsets.symmetric(
                  horizontal: 13
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: 5
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(AppAssets.firdanImg),
                      radius: 60,
                    ),
                  ),
                  Container(
                    width: 5,
                    height: 120,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: BorderRadius.all(Radius.circular(5))
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
                                    '${detailPelamarModel!.data!.worker!.username}',
                                    style: TextStyle(
                                        color: color.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17
                                    ),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '${detailPelamarModel!.data!.worker!.age} Tahun',
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
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              'Kudus, Jawa Tengah, ',
                              style: TextStyle(
                                  color: color.black,
                                  fontSize: 14
                              ),
                            ),
                            Text(
                              'Indonesia',
                              style: TextStyle(
                                  color: color.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
                              decoration: BoxDecoration(
                                  color: color.primary,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Ui/Ux Designer',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: color.white
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 3, horizontal: 5),
                              margin: EdgeInsets.only(right: 7),
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
                ProfilCard(context, AppAssets.activityIcon, 'Deskripsi Lamaran', '${detailPelamarModel!.data!.description}'),
                detailPelamarModel!.data!.confirmedStatus == 'ditolak' ? Container(
                  height: 100,
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(
                    horizontal: 20
                  ),
                  decoration: BoxDecoration(
                    color: color.error.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Text(
                      'Pengguna ini sudah anda tolak!',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                ) : Container()
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: color.white,
        child: InkWell(
          onTap: () async {
            if(detailPelamarModel!.data!.confirmedStatus == 'menunggu'){
              bool isSuccess = await ApiService().defineConfirmation(context, 'diterima', '${detailPelamarModel!.data!.id}');
              if(isSuccess == true){
                setState(() {
                  getdata();
                });
                showDialog(context: context, builder: (context) {
                  return PublicFunction.showDialog(context, 'Lamaran Diterima');
                },);
              } else {
                showDialog(context: context, builder: (context) {
                  return PublicFunction.showDialog(context, 'Ups, Ada kesalahan :(');
                },);
              }
            } else {
              showDialog(context: context, builder: (context) {
                return PublicFunction.showDialog(context, 'Segera Hadir');
              },);
            }
          },
          hoverColor: Colors.black,
          child: Container(
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 18,
            margin: EdgeInsets.symmetric(
                horizontal: 10
            ),
            decoration: BoxDecoration(
                color: detailPelamarModel!.data!.confirmedStatus == 'ditolak' ? color.primary.withOpacity(0.4) : color.primary,
                borderRadius: BorderRadius.circular(12)
            ),
            child: detailPelamarModel!.data!.confirmedStatus == 'diterima' ? Text(
              'Mulai Kontak',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            ) : detailPelamarModel!.data!.confirmedStatus == 'ditolak' ? Text(
              'Undang Wawancara',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            ) : detailPelamarModel!.data!.confirmedStatus == 'menunggu' ? Text(
              'Undang Wawancara',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            ) : Text(
              'Undang Wawancara',
              style: TextStyle(
                  color: color.white,
                  fontWeight: FontWeight.bold
              ),
            )
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
    margin: EdgeInsets.symmetric(
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
            margin: EdgeInsets.only(
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
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
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
            margin: EdgeInsets.symmetric(
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
                SizedBox(
                  height: 13,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Container(
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