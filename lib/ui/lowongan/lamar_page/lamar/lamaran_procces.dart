import 'package:cariin_v2/model/recruit/recruit_list_model.dart';
import 'package:cariin_v2/model/worker/worker_recruit_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/api_service.dart';

class LamaranProccess extends StatefulWidget {
  const LamaranProccess({Key? key}) : super(key: key);

  @override
  State<LamaranProccess> createState() => _LamaranProccessState();
}

class _LamaranProccessState extends State<LamaranProccess> {
  WorkerRecruitListModel? recruitListModel;
  bool _isLoad = false;

  Getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('worker');
    await ApiService().RefreshToken('worker', oldToken);
    WorkerRecruitListModel allJob = await ApiService().getListWorkerRecruit();
    setState(() {
      recruitListModel = allJob;
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
    Getdata();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: _isLoad ? Center(child: CircularProgressIndicator(color: color.primary,),) : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: recruitListModel!.data!.length == 0 ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              recruitListModel!.data!.isEmpty ? const Center(child: Text('Data Kosong'),) : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: recruitListModel!.data!.length,
                itemBuilder: (context, index) {
                  var data = recruitListModel!.data![index];
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.maxFinite,
                      height: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: color.background,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: const Offset(0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: const CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage(AppAssets.firdanImg),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 25, horizontal: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.job!.title!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: color.black,
                                      fontSize: 17),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.work, size: 20, color: color.primary,),
                                    Text(
                                      ' ${data.job!.title!}',
                                      style:
                                      TextStyle(color: color.primary, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
