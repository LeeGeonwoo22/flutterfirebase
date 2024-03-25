import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String? gender;
  String? name;
  String? smoke;
  String? weight;
  String? style;
  String? sendlike;
  String? job;
  String? heart;
  String? drink;
  int? age;
  String? height;
  String? religion;

  Users({
    this.gender,
    this.name,
    this.smoke,
    this.weight,
    this.style,
    this.sendlike,
    this.job,
    this.heart,
    this.drink,
    this.age,
    this.height,
    this.religion,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      gender: map['gender'],
      name: map['name'],
      smoke: map['smoke'],
      weight: map['weight'],
      style: map['style'],
      sendlike: map['sendlike'],
      job: map['job'],
      heart: map['heart'],
      drink: map['drink'],
      age: map['age'],
      height: map['height'],
      religion: map['religion'],
    );
  }

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      gender: json['gender'],
      name: json['name'],
      smoke: json['smoke'],
      weight: json['weight'],
      style: json['style'],
      sendlike: json['sendlike'],
      job: json['job'],
      heart: json['heart'],
      drink: json['drink'],
      age: json['age'],
      height: json['height'],
      religion: json['religion'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['gender'] = gender;
    data['name'] = name;
    data['smoke'] = smoke;
    data['weight'] = weight;
    data['style'] = style;
    data['sendlike'] = sendlike;
    data['job'] = job;
    data['heart'] = heart;
    data['drink'] = drink;
    data['age'] = age;
    data['height'] = height;
    data['religion'] = religion;
    return data;
  }
}
