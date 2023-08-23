// import 'package:cariin_v2/ui/widget/home_widget.dart';
// import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get_time_ago/get_time_ago.dart';
//
// import '../../../../common/app_color.dart';
// import '../../../../common/public_function.dart';
// import '../../../../model/worker/all_job_worker_model.dart';
// import '../../../../service/api_service.dart';
// import '../../detail_lowongan/page.dart';
//
// class SearchPage extends StatefulWidget {
//   SearchPage({Key? key, required this.value}) : super(key: key);
//   String value;
//
//   @override
//   State<SearchPage> createState() => _SearchPageState();
// }
//
// class _SearchPageState extends State<SearchPage> {
//   final TextEditingController _searchTextController = TextEditingController();
//   AllJobWorkerModel? allJobWorkerModel;
//   bool _isLoad = false;
//
//   void updateList(String value) async {
//     if(value.isNotEmpty){
//       _isLoad = true;
//       AllJobWorkerModel allJob = await ApiService().AllJobsWorker();
//       setState(() {
//         allJobWorkerModel!.data = allJob.data!.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList()..where((element) => element.company!.name!.toLowerCase().contains(value.toLowerCase())).toList();
//       });
//       _isLoad = false;
//     } else {
//       AllJobWorkerModel allJob = await ApiService().AllJobsWorker();
//       setState(() {
//         allJobWorkerModel = allJob;
//       });
//     }
//   }
//
//   getData() async {
//     _isLoad = true;
//     final token = await PublicFunction.getToken('worker');
//     await ApiService().RefreshToken('worker', token);
//     AllJobWorkerModel allJob = await ApiService().AllJobsWorker();
//     setState(() {
//       allJobWorkerModel = allJob;
//     });
//     _isLoad = false;
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setState(() {
//       _searchTextController.text = widget.value;
//     });
//
//     getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var color = AppColor.theme(Theme.of(context).brightness);
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: color.background,
//         leading: InkWell(
//           onTap: () => Navigator.of(context).pop(true),
//           child: const Icon(Icons.arrow_back_ios),
//         ),
//         title: Text(
//           widget.value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: color.primary,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, bottom: 20),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 60,
//                       alignment: Alignment.centerLeft,
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         color: color.secondaryContainer,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: TextField(
//                         controller: _searchTextController,
//                         onChanged: (value) => updateList(_searchTextController.text),
//                         style: TextStyle(
//                             color: color.primary, fontSize: 14),
//                         decoration: InputDecoration(
//                           enabledBorder: InputBorder.none,
//                           focusedBorder: InputBorder.none,
//                           suffix: const SizedBox(width: 10),
//                           prefixIcon: const InkWell(
//                             child: Icon(
//                               Icons.search,
//                               size: 20,
//                             ),
//                           ),
//                           prefixIconColor: color.secondary.withOpacity(0.5),
//                           hintText: "Cari loker atau perusahaan",
//                           hintStyle: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: color.secondary.withOpacity(0.5)),
//                         ),
//                       ),
//                     ),
//                     // SizedBox(
//                     //   width: double.infinity,
//                     //   child: Column(
//                     //     crossAxisAlignment: CrossAxisAlignment.start,
//                     //     children: [
//                     //       Text(
//                     //         "Kategori",
//                     //         style: TextStyle(
//                     //             fontSize: 13,
//                     //             fontWeight: FontWeight.w500,
//                     //             color: const Color(0x803A4750)),
//                     //       ),
//                     //       SizedBox(height: 10),
//                     //       Wrap(
//                     //         spacing: 10,
//                     //         runSpacing: 10,
//                     //         children: [
//                     //           CategoryButton(text: "Akutansi dan Keuangan"),
//                     //           CategoryButton(text: "Teknologi"),
//                     //           CategoryButton(text: "Admin"),
//                     //           CategoryButton(text: "Industri"),
//                     //           CategoryButton(text: "Keuangan"),
//                     //           CategoryButton(text: "Programmer"),
//                     //           CategoryButton(text: "Web Developer"),
//                     //           CategoryButton(text: "Mobile Apps Developer"),
//                     //         ],
//                     //       ),
//                     //     ],
//                     //   ),
//                     // ),
//
//                   ],
//                 ),
//               ),
//               _isLoad ? Center(child: ShimmerJobCard(marginHorizon: 0),) : ListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: allJobWorkerModel!.data!.length,
//                 itemBuilder: (context, index) {
//                   var data = allJobWorkerModel!.data!;
//                   int count;
//                   if (data[index].tags!.length == 1) {
//                     count = 1;
//                   } else if (data[index].tags!.length == 2) {
//                     count = 2;
//                   } else {
//                     count = 3;
//                   }
//                   DateTime? date = DateTime.parse(data[index].createdAt.toString());
//                   return InkWell(
//                     onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => JobDetailPage(
//                               id: allJobWorkerModel!.data![index].id!.toInt()),
//                         )),
//                     child: Column(
//                       children: [
//                         Container(
//                           height: 140,
//                           width: double.maxFinite,
//                           margin:
//                           const EdgeInsets.only(top: 20),
//                           decoration: BoxDecoration(
//                             color: color.white,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: color.primaryContainer.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 4,
//                                 offset: const Offset(
//                                     2, 2), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Container(
//                             margin: const EdgeInsets.only(
//                                 top: 10, left: 10, right: 10),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   data[index].title.toString(),
//                                   style: TextStyle(
//                                       color: color.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontSize: 15),
//                                 ),
//                                 const SizedBox(
//                                   height: 5,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       'Pengalaman',
//                                       style: TextStyle(
//                                           color: color.black.withOpacity(0.6),
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     CircleAvatar(
//                                       radius: 5,
//                                       backgroundColor:
//                                       color.black.withOpacity(0.5),
//                                     ),
//                                     const SizedBox(
//                                       width: 5,
//                                     ),
//                                     Text(
//                                       '1 - 3 Tahun',
//                                       style: TextStyle(
//                                           color: color.black.withOpacity(0.6),
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 14),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 3,
//                                 ),
//                                 Expanded(
//                                   child: ListView.builder(
//                                     itemCount: count,
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (context, indexs) {
//                                       return Center(
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                               vertical: 3, horizontal: 5),
//                                           margin: const EdgeInsets.only(right: 7),
//                                           decoration: BoxDecoration(
//                                               color: color.primaryContainer,
//                                               borderRadius:
//                                               BorderRadius.circular(5)),
//                                           child: Text(
//                                             '${data[index].tags![indexs].name}',
//                                             style: const TextStyle(
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 7, left: 2, bottom: 10),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: 40,
//                                         width: 4,
//                                         margin: const EdgeInsets.only(right: 10),
//                                         decoration: BoxDecoration(
//                                             color:
//                                             color.tertiary.withOpacity(0.5),
//                                             borderRadius:
//                                             BorderRadius.circular(2)),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             data[index].company!.name.toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w600,
//                                                 color: color.tertiary
//                                                     .withOpacity(0.8)),
//                                           ),
//                                           Text(
//                                             data[index].company!.location.toString(),
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: color.tertiary
//                                                     .withOpacity(0.8)),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 30,
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(
//                             color: color.primary,
//                             borderRadius: const BorderRadius.only(
//                                 bottomRight: Radius.circular(20)),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: color.primaryContainer.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 4,
//                                 offset: const Offset(
//                                     2, 2), // changes position of shadow
//                               ),
//                             ],
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Text(GetTimeAgo.parse(date, locale: 'id'),
//                                   style: TextStyle(
//                                       color: color.white,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 12)),
//                               const SizedBox(
//                                 width: 13,
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
