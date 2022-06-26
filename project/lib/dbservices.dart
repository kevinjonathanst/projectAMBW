import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dataclass.dart';
import 'dart:math';


CollectionReference tbStok = FirebaseFirestore.instance.collection("tbStok");
CollectionReference tbHistory = FirebaseFirestore.instance.collection("tbHistory");

String getRandomGeneratedId() {
  const int AUTO_ID_LENGTH = 20;
  const String AUTO_ID_ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  
  const int maxRandom = AUTO_ID_ALPHABET.length;
  final Random randomGen = Random();
  
  final StringBuffer buffer = StringBuffer();
  for (int i = 0; i < AUTO_ID_LENGTH; i++) {
    buffer.write(AUTO_ID_ALPHABET[randomGen.nextInt(maxRandom)]);
  }
  
  return buffer.toString();
}

class Database {
  static Stream<QuerySnapshot> getData(){
    return tbStok.snapshots();
  }

  static Stream<QuerySnapshot> getDataHistory(){
    return tbHistory.snapshots();
  }

  static Stream<QuerySnapshot> getjumlah(String namabarang) {
    if(namabarang == ""){
      return tbStok.snapshots();
    } else {
      return tbStok
      // .where("namabarangCat", isEqualTo: namabarang)
      .orderBy("jumlah")
      .startAt([namabarang]).endAt([namabarang + '\uf8ff'])
      .snapshots();
    }
  }

  static Future<void> addData({required StokBarang item}) async {
    DocumentReference docRef = tbStok.doc(item.namabarang);

    await docRef
    .set(item.toJson())
    .whenComplete(() => print("Data berhasil di input"))
    .catchError((e) => print(e));

  }

  static Future<void> addhistory({required History item}) async {
    var rand = getRandomGeneratedId();
    DocumentReference docRef = tbHistory.doc(rand);

    await docRef
    .set(item.toJson())
    .whenComplete(() => print("Data berhasil di input"))
    .catchError((e) => print(e));

  }

  static Future<void> updateData({required StokBarang item, String? namabarang}) async {
    DocumentReference docRef = tbStok.doc(item.namabarang);

    await docRef
    .update(item.toJson())
    .whenComplete(() => print("item berhasil di ubah"))
    .catchError((e) => print(e));
  }

  static Future<void> delData({required String namabaranghapus}) async {
    DocumentReference docRef = tbStok.doc(namabaranghapus);

    await docRef
    .delete()
    .whenComplete(() => print("item berhasil di delete"))
    .catchError((e) => print(e));
  }
}