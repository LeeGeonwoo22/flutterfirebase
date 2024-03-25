import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/users.dart';

// import 'firebase_options.dart';

class Data extends StatelessWidget {
  const Data({super.key});

  void readData() async {
    final userData = FirebaseFirestore.instance.collection('data');
    userData.get().then(
      (querySnapshot) {
        print("Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
    // .doc('CZowEZhKOP96tCEAK8gm');
    // print(userData)
    // final query = await userData.get();
    /*print(jsonEncode(query.data()));*/
    // print(query);
    // final datas =
    //     jsonDecode(jsonEncode(query())); // JSON 문자열로 변환한 뒤 다시 Map으로 변환
    // var item = Users.fromJson(datas);
    // (Users.fromJson(datas));
  }
  // FutureBuilder<List<MapEntry<String, String>>>() {
  //   future:
  //   readData();
  //   builder:
  //   (context, AsyncSnapshot<List<MapEntry<String, String>>> snapshot) {
  //     print(snapshot);
  //   };
  // }

  void createData(String id, String name, int age) {
    print('createData');
    final usercol = FirebaseFirestore.instance.collection('data').doc(id);
    usercol.set({
      "name": name,
      "age": age,
    });
  }

  void updateData(String id, String name, int age) async {
    print('update');
    final usercol = FirebaseFirestore.instance.collection('data').doc(id);
    // usercol.update({
    //   "name": name,
    //   "age": age,
    //   "hobby": "none",
    // });
    // 해당 값이 있으면 해당값을 업데이트 나머지의 값들은 남겨둠
    usercol.update({
      "hobby": "축구",
    });
  }

  void deleteData(String id) {
    print('delete');
    final usercol = FirebaseFirestore.instance.collection('data').doc("$id");
    usercol.delete();
  }

  @override
  Widget build(BuildContext context) {
    readData();
    createData('12', '하남자', 25);
    updateData("12", "상남자", 26);
    deleteData("12");
    return Scaffold();
  }
}
