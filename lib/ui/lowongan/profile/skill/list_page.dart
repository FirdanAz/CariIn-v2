// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/worker/skill_list_model.dart';
import '../../../../service/api_service.dart';
import '../../../widget/auth_text_field.dart';

class ListSkillPage extends StatefulWidget {
  const ListSkillPage({Key? key}) : super(key: key);

  @override
  State<ListSkillPage> createState() => _ListSkillPageState();
}

class _ListSkillPageState extends State<ListSkillPage> {
  SkillListModel? skillListModel;
  bool _isLoad = false;

  final _nameController = TextEditingController();

  getdata() async {
    _isLoad = true;
    SkillListModel model = await ApiService().ListSkillsWorker();
    setState(() {
      skillListModel = model;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
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
        title: const Text('Keahlian', style: TextStyle(
          fontSize: 20,
        ),),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: color.primary,
          ),
        ),
      ),
      body: _isLoad ? const Center(child: CircularProgressIndicator(),) : skillListModel!.data!.isEmpty ? const Center(child: Text('Belum ada Keahlian'),) :
      Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: skillListModel!.data!.length,
            itemBuilder: (context, index) {
              var data = skillListModel!.data![index];
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
                                  data.name!,
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
                            onTap: () {
                              showDialog(context: context, builder: (context) {
                                return AlertDialog(
                                  title: Text('Yakin untuk menghapush ${data.name}?', style: TextStyle(color: color.black, fontSize: 15),),
                                  actions: [
                                    ElevatedButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Batal')),
                                    ElevatedButton(
                                      onPressed: () async {
                                        bool isDeleted = await ApiService().deleteSkills(data.id!.toString());
                                        if(isDeleted == true){
                                          Navigator.of(context).pop();
                                          showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Skill dihapus'),);
                                          setState(() {
                                            getdata();
                                          });
                                        }
                                      },
                                      child: Text('Hapus', style: TextStyle(color: color.error),),
                                    )
                                  ],
                                );
                              },);
                            },
                            child: Icon(Icons.delete, color: color.primary,),
                          ),
                        )
                      ]
                  )
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: ElevatedButton(
          onPressed: () async {
            showLoaderDialog(context);
            await Future.delayed(const Duration(seconds: 1));
            Navigator.of(context).pop();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Nama Skill',
                          style: TextStyle(color: color.primary),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFieldComp(
                            emailController: _nameController,
                            hintText: 'Nama Skills',
                            textInputType: TextInputType.text),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if(_nameController.text.isNotEmpty){
                            bool isSucces = await ApiService().addSkillsWorker(_nameController.text);
                            if(isSucces == true){
                              Navigator.of(context).pop();
                              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Skill Ditambahkan'),);
                              setState(() {
                                _nameController.text = '';
                                getdata();
                              });
                            }
                          }
                        },
                        child: const Text('Tambah')
                    )
                  ],
                );
              },
            );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color.primaryContainer)
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add),
              Text('Tambah Keahlian')
            ],
          ),
        ),
      ),
    );
  }
}
