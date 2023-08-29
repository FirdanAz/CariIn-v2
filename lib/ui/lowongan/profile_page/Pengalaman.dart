import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/model/worker/experience/experience_list.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PengalamanPage extends StatefulWidget {
  const PengalamanPage({super.key});

  @override
  State<PengalamanPage> createState() => _PengalamanPageState();
}

class _PengalamanPageState extends State<PengalamanPage> {
  ListExperienceModel? listExperienceModel;
  bool _isLoad = false;
  final List<String> menuItems = ['Option 1', 'Option 2', 'Option 3'];

  getData() async {
    _isLoad = true;
    ListExperienceModel experienceModel =
        await DataService().getListExperience();
    setState(() {
      listExperienceModel = experienceModel;
    });
    _isLoad = false;
  }

  void _showPopupMenu(BuildContext context, Offset position) async {
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
          child: Text('Hapus'),
          labelTextStyle: MaterialStatePropertyAll(TextStyle(color: color.error)),
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
    var color = AppColor.theme(Theme.of(context).brightness);
    return _isLoad
        ? SizedBox(height: 400, child: Center(child: CircularProgressIndicator()),)
        : Column(
            children: [
              Container(
                height: 60,
                width: double.maxFinite,
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(color.primaryContainer),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {},
                  child: const Text('Tambah Pengalaman'),
                ),
              ),
              listExperienceModel!.data!.isEmpty ?
              Container(
                color: color.error.withOpacity(0.2),
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(10),
                child: Center(child: Text('Belum ada pengalaman'),),
              ) :
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listExperienceModel!.data!.length,
                  itemBuilder: (context, index) {
                    var data = listExperienceModel!.data![index];
                    return Container(
                        decoration: BoxDecoration(
                          color: color.primaryContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(left: 10, top: 5),
                                          child: Text(
                                            data.title!,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: color.primary
                                            ),
                                          ),
                                        ),
                                        const Padding(padding: EdgeInsets.all(1)),
                                        Container(
                                          margin: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            '${data.location!} | ${data.startAt} - ${data.endAt}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: color.secondary
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: GestureDetector(
                                      onTapUp: (TapUpDetails details) {
                                        _showPopupMenu(context, details.globalPosition);
                                      },
                                      child: Icon(Icons.more_vert, color: color.primary,)
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(padding: EdgeInsets.all(1)),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.only(right: 10, bottom: 10),
                                child: Text(
                                  data.description!,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: color.secondary
                                  ),
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          );
  }
}
