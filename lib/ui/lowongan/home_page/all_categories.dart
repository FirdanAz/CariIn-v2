// ignore_for_file: must_be_immutable

import 'package:cariin_v2/common/app_assets.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/lowongan/home_page/search/search_page_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
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
      ),
      body: Container(
        margin: EdgeInsets.only(top: 7, bottom: 7),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            CategoriesCard(title: 'Pemprograman', image: AppAssets.codeIcon),
            CategoriesCard(title: 'Desainer', image: AppAssets.designIcon),
            CategoriesCard(title: 'Guru', image: AppAssets.teacherIcon),
            CategoriesCard(title: 'Medis', image: AppAssets.medicalIcon),
            CategoriesCard(title: 'Bisnis', image: AppAssets.BisnisIcon),
            CategoriesCard(title: 'Marketing', image: AppAssets.MarketingIcon),
            CategoriesCard(title: 'Teknik', image: AppAssets.TeknikIcon),
            CategoriesCard(
                title: 'Costumer Service',
                image: AppAssets.CustomerServiceIcon),
            CategoriesCard(title: 'Perusahaan', image: AppAssets.PersuhaanIcon),
            CategoriesCard(title: 'Otomotif', image: AppAssets.OtomotifIcon),
            CategoriesCard(title: 'Retail', image: AppAssets.RetailIcon),
            CategoriesCard(
                title: 'Pemerintahan', image: AppAssets.PemerintahanIcon),
          ],
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  CategoriesCard({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  String title;
  String image;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SearchResultPage(value: title),)),
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: color.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: color.primaryContainer,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, left: 25),
                  child: SvgPicture.asset(
                    image,
                    height: 80,
                    color: color.primary,
                  ),
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: color.primaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
