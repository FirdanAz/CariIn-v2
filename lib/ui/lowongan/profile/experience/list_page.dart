// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/ui/lowongan/profile/experience/form/create_experience.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../../model/worker/experience/experience_list.dart';
import '../../../../service/edit_service.dart';

class ExperienceListPage extends StatefulWidget {
  const ExperienceListPage({Key? key}) : super(key: key);

  @override
  State<ExperienceListPage> createState() => _ExperienceListPageState();
}

class _ExperienceListPageState extends State<ExperienceListPage> {
  ListExperienceModel? listExperienceModel;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    ListExperienceModel experienceModel =
    await DataService().getListExperience();
    setState(() {
      listExperienceModel = experienceModel;
    });
    _isLoad = false;
  }

  void _showPopupMenu(BuildContext context, Offset position, String id) async {
    var color = AppColor.theme(Theme.of(context).brightness);
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, 0, 0),
      color: color.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      items: [
        PopupMenuItem<String>(
          value: 'edit',
          child: Text('Ubah'),
          labelTextStyle: MaterialStatePropertyAll(TextStyle(color: color.primary)),

        ),
        PopupMenuItem<String>(
          value: 'delete',
          labelTextStyle: MaterialStatePropertyAll(TextStyle(color: color.error)),
          child: const Text('Hapus'),
          onTap: () async {
            bool success = await DataService().deleteExperience(id);
            if(success == true){
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Pengalaman Dihapus'),);
              setState(() {
                getData();
              });
            } else {
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Ada Kesalahan Sistem!'),);
            }
          },
        ),
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    showLoaderDialog(BuildContext context) {
      var color = AppColor.theme(Theme.of(context).brightness);
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
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengalaman', style: TextStyle(fontSize: 20),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios_new, color: color.primary,),
        ),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) : Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: listExperienceModel!.data!.length,
            itemBuilder: (context, index) {
              var data = listExperienceModel!.data![index];
              return InkWell(
                child: _experienceItem(data.title!, data.description!, data.id!.toString())
              );
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        child: ElevatedButton(
          onPressed: () async {
            showLoaderDialog(context);
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();
            final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => CreateExperiencePage(),));
            if(result != null){
              setState(() {
                getData();
              });
            }
          },
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color.primaryContainer)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('Tambah Pengalaman')
            ],
          ),
        ),
      ),
    );
  }
  Widget _experienceItem(String title, String subtitle, String id) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return ListTile(
      leading: Image.asset(
        AppAssets.sliderImage,
        width: 80,
        height: 80,
        fit: BoxFit.fill,
      ),
      trailing:  GestureDetector(
          onTapUp: (TapUpDetails details) {
            _showPopupMenu(context, details.globalPosition, id.toString());
          },
          child: Icon(Icons.more_vert, color: color.primary,)
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: color.primary),),
      subtitle: Text(subtitle, maxLines: 3,),
      // Tambahkan detail pengalaman atau aksi lainnya di sini
    );
  }
}
