import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/users.dart';

// import 'firebase_options.dart';

class Data {
  static Future<List<Users>> readData() async {
    final userData = FirebaseFirestore.instance.collection('data');
    try {
      final querySnapshot = await userData.get();
      List<Users> usersList = [];
      for (var docSnapshot in querySnapshot.docs) {
        // Assuming Users class has constructor like Users.fromMap(Map<String, dynamic> data)
        Users user = Users.fromMap(docSnapshot.data());
        usersList.add(user);
      }
      return usersList;
    } catch (e) {
      print("Error completing: $e");
      return []; // Return empty list or handle error case accordingly
    }
  }

  static createData(String id, String name, int age) {
    print('createData');
    final usercol = FirebaseFirestore.instance.collection('data').doc(id);
    usercol.set({
      "name": name,
      "age": age,
    });
  }

  static updateData(String id, String name, int age) async {
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

  static deleteData(String id) {
    print('delete');
    final usercol = FirebaseFirestore.instance.collection('data').doc("$id");
    usercol.delete();
  }

// Widget build(BuildContext context) {
//   readData();
//   createData('12', '하남자', 25);
//   updateData("12", "상남자", 26);
//   deleteData("12");
//   return Scaffold();
// }
}
