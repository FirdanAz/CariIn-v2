
import 'package:cariin_v2/ui/widget/shimmer_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_assets.dart';
import '../../../../common/app_color.dart';
import '../../../../common/public_function.dart';
import '../../../../model/worker/worker_application_model.dart';
import '../../../../service/api_service.dart';
import '../../../lowongan/chat_page/chat_pekerja.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  WorkerApplicationModel? jobApplicationModel;
  bool _isLoad = false;
  final CollectionReference _lowongan = FirebaseFirestore.instance
      .collection('users');

  getdata() async {
    _isLoad = true;
    String oldToken = await PublicFunction.getToken('company');
    await ApiService().RefreshToken('company', oldToken);
    WorkerApplicationModel allJob = await ApiService().getWorkerResult(false, 'wawancara');
    setState(() {
      jobApplicationModel = allJob;
    });
    _isLoad = false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    var color = AppColor.theme(Theme.of(context).brightness);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isLoad ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CustomShimmer(width: double.maxFinite, height: 75, radius: 10),
                  ) : StreamBuilder(
                    stream: _lowongan.snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if(streamSnapshot.hasData){
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documnentSnapshot =
                          streamSnapshot.data!.docs[index];
                            return Container(
                              color: color.primaryContainer,
                              child: ListTile(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPekerja(),)),
                                leading: CircleAvatar(
                                  child: Icon(Icons.account_circle_rounded),
                                ),
                                title: Text(documnentSnapshot['userName']),
                              ),
                            );
                          },
                        );
                      } return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },

                  )

                ])),
      ));
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Text('Error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading');
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs
          .map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    print(data['username']);

    return Container(
      height: 20,
      width: double.maxFinite,
      child: ListTile(
        title: data['userName'],
      ),
    );
  }
}
