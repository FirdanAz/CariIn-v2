// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/karyawan/detail_profile/send_notif_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_color.dart';
import '../../../../model/company/inbox/list.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({Key? key}) : super(key: key);

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  bool _isLoad = false;
  ListInboxModel? listInboxModel;
  bool _reverse = true;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('company', await PublicFunction.getToken('company'));
    ListInboxModel inboxModel = await DataService().getInboxList('company');
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
      appBar: AppBar(
        title: const Text('Kotak Masuk'),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) :
      RefreshIndicator(
        onRefresh: () async {
          setState(() {
            getData();
          });
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _reverse ? 'Terbaru' : 'Terlama',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                        color: color.primary,
                      ),
                    ),
                    InkWell(
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
                listInboxModel!.data!.isEmpty ?
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.error.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(child: Text('Tidak ada Pemberitahuan'),),
                ) :
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
                    Container(
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
                    ):
                    InkWell(
                      onTap: () async {
                        if(data.read == false){
                          bool isSuccess = await DataService().postReadInbox(data.id!.toString(), 'company');
                          if(isSuccess == true){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const SendNotifExample(),));
                            setState(() {
                              getData();
                            });
                          }
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
                Container(constraints: const BoxConstraints(minHeight: 400),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
