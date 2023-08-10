import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/app_color.dart';

class BirthDate extends StatefulWidget {
  const BirthDate({super.key});

  @override
  State<BirthDate> createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  DateTime dateTime = DateTime(2000, 2, 1, 10, 20);

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
          'Tanggal Lahir',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        toolbarHeight: 80,
        backgroundColor: color.surface,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            width: double.maxFinite,
            color: color.secondary,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) => SizedBox(
                    height: 250,
                    width: double.maxFinite,
                    child: CupertinoDatePicker(
                      backgroundColor: color.surfaceContainer,
                      initialDateTime: dateTime,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() => dateTime = newTime);
                      },
                      use24hFormat: true,
                      mode: CupertinoDatePickerMode.date,
                    ),
                  ),
                );
              },
              color: color.primary,
              child: Text(
                'Pilih Tanggal',
                style: TextStyle(
                  color: color.surface,
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
