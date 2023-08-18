// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class FirebaseApiService {
  Future firebaseSendNotif(String deviceToken, String title, String desc) async {
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "key=AAAAHWSPaCs:APA91bGgTL5ml9QkaTwFc4J7p5LPkOFsSGrlXu8zI4NOL7XeUu2nftv7CNAuyZcg6U2m3gqpEMrZiCYI_U2EQ4KD3cGeW9BRUckATNA9KO4jq_io10ovLGQagZLOiAbhhDCwmQY0d66B"
    };

    final body = {
      "to": deviceToken,
      "notification": {
        "title": title,
        "body": desc,
        "image": "<https://marketplace.canva.com/EAEVmoaVxDQ/2/0/800w/canva-logo-acara-catur-sederhana-%26-melingkar-arang-dan-krem-Bdn6Im6_-Ts.jpg>",
        "mutable_content": true,
        "sound": "Tri-tone"
      },

      "data": {
        "image": "<https://example.com/image.jpg>"
      }
    };

    try {
      final response = await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'), body: json.encode(body), encoding: Encoding.getByName('utf-8'), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        print('send Notif');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}