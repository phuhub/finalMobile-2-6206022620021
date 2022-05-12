import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Database {
  FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String gender, String age, String weight,
      String height, String bmical) async {
    try {
      await firestore.collection("bmi").add({
        //'name': name,
        //'code': code,
        'name': name,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
        'bmical': bmical,
        'timestamp': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("bmi").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore.collection('bmi').orderBy('timestamp').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "gender": doc["gender"],
            "age": doc["age"],
            "weight": doc["weight"],
            "height": doc["height"],
            "bmical": doc["bmical"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String name, String gender, String age,
      String weight, String height, String bmical) async {
    try {
      await firestore.collection("bmi").doc(id).update({
        'name': name,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
        'bmical': bmical,
      });
    } catch (e) {
      print(e);
    }
  }
}
