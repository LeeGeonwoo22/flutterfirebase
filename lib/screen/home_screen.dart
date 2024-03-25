import 'package:firebaseflutter/database/firestore.dart';
import 'package:firebaseflutter/models/users.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<Users>> Members = Data.readData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          "데이터 받기",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Members,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [Expanded(child: makeList(snapshot))],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

ListView makeList(AsyncSnapshot<List<Users>> snapshot) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: snapshot.data!.length,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    itemBuilder: (context, index) {
      var user = snapshot.data![index];
      return Container(
        child: Column(
          children: [
            Text(user.name ?? ""),
            // 이름은 문자열로 표시
            Text(user.age != null ? user.age.toString() : ""),
            // 나이는 정수로 변환 후 문자열로 표시
            Text(user.gender ?? ""),
            // 성별은 문자열로 표시
          ],
        ),
      );
    },
    separatorBuilder: (context, index) => const SizedBox(width: 40),
  );
}
