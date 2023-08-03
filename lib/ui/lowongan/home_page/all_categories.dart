import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<Map> myCategorys =
      List.generate(12, (index) => {"id": index, "name": "Pekerjaan $index"})
          .toList();
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      backgroundColor: color.surfaceContainer,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Container(
          child: InkWell(
            onTap: () => Navigator.of(context).pop(true),
            child: Icon(Icons.arrow_back_ios),
          ),
          margin: EdgeInsets.only(left: 15),
        ),
        centerTitle: true,
        title: Text(
          'Kategori',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 220,
          childAspectRatio:2/2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 5,),
            itemCount: myCategorys.length,
        itemBuilder: (_, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: color.white,
              borderRadius: BorderRadius.circular(10)
            ),
          );
        },
        ),
    );
  }
}