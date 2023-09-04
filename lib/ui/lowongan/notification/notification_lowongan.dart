import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/model/company/inbox/list.dart';
import 'package:cariin_v2/service/api_service.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../../../common/app_color.dart';

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
                  ) : listInboxModel!.data!.isEmpty ? const SizedBox(height: 500, child: Center(child: Text('Tidak ada Kotak Masuk'),)) : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: listInboxModel!.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = listInboxModel!.data![index];
                      return Container(
                        decoration: BoxDecoration(
                            color: color.surface,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.maxFinite,
                        height: 75,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(AppAssets.firdanImg),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    width: double.maxFinite,
                                    child: Text(
                                      data.subject!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    width: double.maxFinite,
                                    child: const Text(
                                      '09:21 AM',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
