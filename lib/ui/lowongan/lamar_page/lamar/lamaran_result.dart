import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cariin_v2/common/app_color.dart';
import 'package:cariin_v2/common/app_assets.dart';

class LamaranResult extends StatelessWidget {
  const LamaranResult({Key? key, required this.status}) : super(key: key);
  final String status;

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);
    return Column(children: [
      SizedBox(height: 10),
      Container(
        height: 35,
        width: 430,
        decoration: BoxDecoration(
          color: color.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Diterima',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(10),
        child: Ink(
          width: 425,
          height: 110,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 3,
                // offset: const Offset(0, 4),
              )
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://winaero.com/blog/wp-content/uploads/2018/08/Windows-10-user-icon-big.png',
                  fit: BoxFit.cover,
                  height: 50,
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: 210,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile Development",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: color.primary),
                    ),
                    Text(
                      "PT. Nano group",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: color.primary),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.verified, size: 12, color: color.primary),
                        SizedBox(width: 3.5),
                        Text(
                          'Diterima',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: color.primary),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      "Dilamar pada 13 Aplir 2018",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 8,
                        color: color.primary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
