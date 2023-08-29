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

  getData() async {
    _isLoad = true;
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

    return Scaffold(
      appBar: _appBar(),
      body: _isLoad ? const Center(
        child: CircularProgressIndicator(),
      ) : Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: color.primaryContainer,
                      radius: 45,
                      backgroundImage: NetworkImage('https://cariin.my.id/storage/${profileWorkerModel!.data!.profileImage}'),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          workerModels!.data!.username!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          workerModels!.data!.email!,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppAssets.editIcon, color: color.black.withOpacity(0.3),),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    var color = AppColor.theme(Theme.of(context).brightness);
    return AppBar(
      title: Text(
        'Profil Saya',
        style: TextStyle(
            color: color.black,
            fontSize: 17,
            fontWeight: FontWeight.w600
        ),
      ),
      centerTitle: true,
      backgroundColor: color.background,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Icon(
            Icons.more_vert,
            color: color.black,
          ),
        )
      ],
    );
  }
}
