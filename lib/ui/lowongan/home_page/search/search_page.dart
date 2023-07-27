import 'package:cariin_v2/ui/widget/home_widget.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_color.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color.background,
        title: Text(
          "Search",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color.primary,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 15
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: color.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _searchTextController,
                      autofocus: true,
                      style: TextStyle(
                          color: color.secondaryContainer, fontSize: 14),
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        suffix: SizedBox(width: 10),
                        prefixIcon: Icon(Icons.search, size: 20),
                        prefixIconColor:
                        color.secondary.withOpacity(0.5),
                        hintText: "Cari loker atau perusahaan",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: color.secondary.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Kategori",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: const Color(0x803A4750)),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            CategoryButton(text: "Akutansi dan Keuangan"),
                            CategoryButton(text: "Teknologi"),
                            CategoryButton(text: "Admin"),
                            CategoryButton(text: "Industri"),
                            CategoryButton(text: "Keuangan"),
                            CategoryButton(text: "Programmer"),
                            CategoryButton(text: "Web Developer"),
                            CategoryButton(text: "Mobile Apps Developer"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
