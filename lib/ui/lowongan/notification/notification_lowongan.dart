// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/company/inbox/list.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_color.dart';
import '../../karyawan/detail_profile/send_notif_example.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  ListInboxModel? listInboxModel;
  bool _isLoad = false;
  bool _reverse = true;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    ListInboxModel inboxModel = await DataService().getInboxList('worker');
    setState(() {
      listInboxModel = inboxModel;
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
      backgroundColor: color.background,
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: color.background,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _isLoad ? 10 : 15, vertical: 9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isLoad ? CustomShimmer(width: 100, height: 36, radius: 0) :  Text(
                    _reverse ? 'Terbaru' :'Terlama',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: color.primary,
                    ),
                  ),
                  _isLoad ? CustomShimmer(width: 110, height: 36, radius: 100) : InkWell(
                    onTap: () async {
                      if(_reverse == false && listInboxModel!.data!.isNotEmpty){
                        showLoaderDialog(context);
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.of(context).pop();
                        setState(() {
                          _reverse = true;
                        });
                      } else if(_reverse == true && listInboxModel!.data!.isNotEmpty){
                        showLoaderDialog(context);
                        await Future.delayed(const Duration(milliseconds: 500));
                        Navigator.of(context).pop();
                        setState(() {
                          _reverse = false;
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: color.primary, width: 1)
                      ),
                      child: Row(
                        children: [
                          Text('Urutkan', style: TextStyle(color: color.primary),),
                          const SizedBox(width: 6,),
                          Icon(Icons.change_circle, color: color.primary,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isLoad ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: ShimmerPelamar(itemCount: 2),
                  ) : listInboxModel!.data!.isEmpty ? const SizedBox(height: 500, child: Center(child: Text('Tidak ada Kotak Masuk'),)) :
                  ListView.builder(
                    reverse: _reverse,
                    physics: const BouncingScrollPhysics(),
                    itemCount: listInboxModel!.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = listInboxModel!.data![index];
                      DateTime currentDate = DateTime.now();
                      DateTime dates = DateTime.parse(data.sentDate!);
                      DateTime? date =
                      DateTime.parse(data.sentDate.toString());
                      return data.read == true ?
                      InkWell(
                        overlayColor: MaterialStatePropertyAll(Colors.transparent),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDetailPage(title: data.subject!, message: data.message!),));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: color.surface,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.white,
                                radius: 25,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(AppAssets.appsLogo),
                                ),
                              ),
                              title: Text(
                                data.subject!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: color.black.withOpacity(0.8), fontWeight: FontWeight.w600, fontSize: 17),
                              ),
                              subtitle: Text(
                                data.message!,
                                style: TextStyle(
                                  color: color.black.withOpacity(0.8),
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    GetTimeAgo.parse(date, locale: 'id'),
                                    style: TextStyle(
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    'Dibaca',
                                    style: TextStyle(
                                        color: color.secondary
                                    ),
                                  )
                                ],
                              ),
                            )
                        ),
                      ):
                      InkWell(
                        onTap: () async {
                          if(data.read == false){
                            bool isSuccess = await DataService().postReadInbox(data.id!.toString(), 'worker');
                            if(isSuccess == true){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDetailPage(title: data.subject!, message: data.message!),));
                              setState(() {
                                getData();
                              });
                            }
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationDetailPage(title: data.subject!, message: data.message!),));
                          }
                        },
                        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
                        child: Container(
                            decoration: BoxDecoration(
                                color: color.surface,
                                borderRadius: BorderRadius.circular(10)),
                            width: double.maxFinite,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: color.white,
                                radius: 25,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(AppAssets.appsLogo),
                                ),
                              ),
                              title: Text(
                                data.subject!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: color.black, fontWeight: FontWeight.w700, fontSize: 17),
                              ),
                              subtitle: Text(
                                data.message!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: color.black,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    GetTimeAgo.parse(date, locale: 'id'),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Text(
                                    'Baru',
                                    style: TextStyle(
                                        color: color.secondary,
                                        fontWeight: FontWeight.w600
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final String title;
  final String message;


  NotificationDetailPage({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Notifikasi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  AppAssets.appsLogo,
                  width: double.infinity, // Gambar akan memenuhi lebar layar.
                  height: 200,// Mengatur bagaimana gambar ditampilkan dalam kotak gambar.
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              message,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
