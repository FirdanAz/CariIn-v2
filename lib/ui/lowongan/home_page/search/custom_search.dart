import 'package:cariin_v2/ui/lowongan/home_page/search/search_page.dart';
import 'package:cariin_v2/ui/lowongan/home_page/search/search_page_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';

class CustomSearch extends SearchDelegate {
  List<Map<String, dynamic>> listDataSearch = [
    {'icon': AppAssets.codeIcon, 'value': 'Developer'},
    {'icon': AppAssets.designIcon, 'value': 'Designer'},
    {'icon': AppAssets.BisnisIcon, 'value': 'Bisnis'},
    {'icon': AppAssets.OtomotifIcon, 'value': 'Otomotif'},
    {'icon': AppAssets.TeknikIcon, 'value': 'Teknik'},
  ];

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => query != '' ? TextStyle(
    color: AppColor.theme(Brightness.light).primary,
    fontWeight: FontWeight.w600
  ) : TextStyle(color: AppColor.theme(Brightness.light).primaryContainer, fontWeight: FontWeight.w600);


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      query != '' ? IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)
      ) : Container()
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_ios_new), color: color.primary,);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ListSearchResult(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kategori",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0x803A4750)),
          ),
          const SizedBox(height: 10,),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listDataSearch.length,
            itemBuilder: (context, index) {
              var result = listDataSearch[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.primaryContainer
                ),
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 16,
                      backgroundColor: color.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SvgPicture.asset(
                          listDataSearch[index]['icon'],
                          color: color.white,
                        ),
                      )),
                  onTap: () {
                    query = result['value'];
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SearchResultPage(value: query);
                      },
                    ));
                  },
                  title: Text(result['value'],style: TextStyle(color: color.primary),),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
