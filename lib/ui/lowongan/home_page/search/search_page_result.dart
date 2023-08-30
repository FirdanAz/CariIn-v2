import 'package:cariin_v2/model/worker/edit_data_model/search_model.dart';
import 'package:cariin_v2/service/edit_service.dart';
import 'package:flutter/material.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../service/api_service.dart';
import '../../../widget/shimmer_widget.dart';
import '../../detail_lowongan/page.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({Key? key, required this.value}) : super(key: key);
  String value;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(true),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color.primary,
          ),
        ),
      ),
      body: ListSearchResult(query: value),
    );
  }
}

class ListSearchResult extends StatefulWidget {
  ListSearchResult({Key? key, required this.query}) : super(key: key);
  String query;

  @override
  State<ListSearchResult> createState() => _ListSearchResultState();
}

class _ListSearchResultState extends State<ListSearchResult> {
  bool _isLoad = false;
  bool _jobsIsNull = false;
  bool _companyIsNull = false;
  WorkerSearchModel? workerSearchModel;
  WorkerSearchModel? companySearchModel;

  getData() async {
    _isLoad = true;
    await ApiService().RefreshToken('worker', await PublicFunction.getToken('worker'));
    WorkerSearchModel searchModel = await DataService().getListSearch(widget.query);
    if(searchModel.data!.jobs!.isEmpty) {
      _jobsIsNull = true;
      WorkerSearchModel searchModel1 = await DataService().getListSearch('api');
      WorkerSearchModel searchModel2 = await DataService().getListSearch(widget.query);
      setState(() {
        workerSearchModel = searchModel1;
        workerSearchModel!.data!.jobs?.sort((a, b) => a.company!.name!.toLowerCase().toString().compareTo(widget.query.toLowerCase().toString()));
        //workerSearchModel!.data!.jobs = searchModel1.data!.jobs!.where((element) => element.company!.name!.toLowerCase().toString().contains(widget.query.toLowerCase().toString())).toList();
      });
      if(searchModel2.data!.companies!.isEmpty) {
        _companyIsNull = true;
      } else {
        _companyIsNull = false;
        setState(() {
          companySearchModel = searchModel2;
        });
      }
    } else{
      setState(() {
        _companyIsNull = true;
        workerSearchModel = searchModel;
      });
    }
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
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          getData();
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoad ?
            Container() : _companyIsNull == false ?
            ListView.builder(
              shrinkWrap: true,
              itemCount: companySearchModel!.data!.companies!.length,
              itemBuilder: (context, index) {
                var data = companySearchModel!.data!.companies![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://cariin.my.id/storage/${data.profileImage}'),
                  ),
                  title: Text(data.name!),
                  subtitle: Text(data.email!),
                  trailing: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: data.confirmedStatus! == 'diterima' ? Colors.green : color.primaryContainer,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      data.confirmedStatus! == 'diterima' ? 'Terverifikasi' : 'Belum Terverifikasi',
                      style: TextStyle(
                        color: data.confirmedStatus! == 'diterima' ? color.white : color.black
                      ),
                    ),
                  ),
                );
              },
            ) : Container(),
            _isLoad ? Center(child: ShimmerJobCard(marginHorizon: 0),) : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _jobsIsNull == true ? _companyIsNull == true ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(child: Text('Pekerjaan tidak ditemukan', style: TextStyle(color: color.error),),),
              ) : Container() : Container(),
            ),
            _isLoad ? Center(child: ShimmerJobCard(marginHorizon: 0),) :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  _jobsIsNull == true ? Text(
                    'Pekerjaan lain',
                    style: TextStyle(
                      color: color.black,
                      fontSize: 17,
                      fontWeight: FontWeight.w600
                    ),
                  ) : Container(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: workerSearchModel!.data!.jobs!.length,
                    itemBuilder: (context, index) {
                      var data = workerSearchModel!.data!.jobs!;
                      int count;
                      if (data[index].tags!.length == 1) {
                        count = 1;
                      } else if (data[index].tags!.length == 2) {
                        count = 2;
                      } else {
                        count = 3;
                      }
                      DateTime? date = DateTime.parse(data[index].createdAt.toString());
                      return InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailPage(
                                  id: workerSearchModel!.data!.jobs![index].id!.toInt()),
                            )),
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: double.maxFinite,
                              margin:
                              const EdgeInsets.only(top: 20),
                              decoration: BoxDecoration(
                                color: color.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: color.primaryContainer.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 10, right: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].title.toString(),
                                      style: TextStyle(
                                          color: color.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Pengalaman',
                                          style: TextStyle(
                                              color: color.black.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor:
                                          color.black.withOpacity(0.5),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '1 - 3 Tahun',
                                          style: TextStyle(
                                              color: color.black.withOpacity(0.6),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: count,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, indexs) {
                                          return Center(
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 3, horizontal: 5),
                                              margin: const EdgeInsets.only(right: 7),
                                              decoration: BoxDecoration(
                                                  color: color.primaryContainer,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Text(
                                                '${data[index].tags![indexs].name}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 7, left: 2, bottom: 10),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 4,
                                            margin: const EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color:
                                                color.tertiary.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(2)),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index].company!.name.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: color.tertiary
                                                        .withOpacity(0.8)),
                                              ),
                                              Text(
                                                data[index].company!.location.toString(),
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: color.tertiary
                                                        .withOpacity(0.8)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 30,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: color.primary,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: color.primaryContainer.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(
                                        2, 2), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(GetTimeAgo.parse(date, locale: 'id'),
                                      style: TextStyle(
                                          color: color.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                  const SizedBox(
                                    width: 13,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}

