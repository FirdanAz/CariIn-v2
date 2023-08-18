// ignore_for_file: use_build_context_synchronously

import 'package:cariin_v2/common/public_function.dart';
import 'package:cariin_v2/service/firebase_api_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class SendNotifExample extends StatefulWidget {
  const SendNotifExample({Key? key}) : super(key: key);

  @override
  State<SendNotifExample> createState() => _SendNotifExampleState();
}

class _SendNotifExampleState extends State<SendNotifExample> {
  String? deviceToken;
  bool _isLoad = false;

  getData() async {
    _isLoad = true;
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    setState(() {
      deviceToken = fcmToken;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoad ? const Text('Memuat...') : ElevatedButton(
          onPressed: () async {
            bool isSuccess = await FirebaseApiService().firebaseSendNotif(deviceToken!, 'Send notif', 'Bakso bakso');
            if(isSuccess){
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Kirim Notif bisa'),);
            } else {
              showDialog(context: context, builder: (context) => PublicFunction.showDialog(context, 'Kirim Notif Gagal'),);
            }
          },
          child: Text('Send Notif'),
        ),
      ),
    );
  }
}
