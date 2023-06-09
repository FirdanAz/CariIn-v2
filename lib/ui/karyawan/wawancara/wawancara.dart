import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/ui/karyawan/list_karyawan/karyawan_list_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_assets.dart';

class WawancaraPage extends StatefulWidget {
  const WawancaraPage({Key? key}) : super(key: key);

  @override
  State<WawancaraPage> createState() => _WawancaraPageState();
}

class _WawancaraPageState extends State<WawancaraPage> {
  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Brightness.light);

    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: color.primary,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(AppAssets.wIcon, width: 40,),
                ),
              ),
              SizedBox(height: 25,),
              Text(
                'Belum ada Pekerja',
                style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w600
                ),
              ),

              SizedBox(height: 30,),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 40
                ),
                child: InkWell(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ListKaryawan(),)),
                  child: Container(
                    width: double.maxFinite,
                    height: 50,
                    decoration: BoxDecoration(
                        color: color.primary,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        'Cari Pekerja',
                        style: TextStyle(
                            fontSize: 15,
                            color: color.white
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
