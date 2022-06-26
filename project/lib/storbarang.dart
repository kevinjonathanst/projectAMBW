import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/dataclass.dart';
import 'package:firebase_core/firebase_core.dart';

import 'dbservices.dart';

class AddBarang extends StatefulWidget {
  const AddBarang({Key? key}) : super(key: key);

  @override
  State<AddBarang> createState() => _AddBarangState();
}

Future<bool> checknotExist(String docID) async {
  DocumentSnapshot<Map<String, dynamic>> document =
      await FirebaseFirestore.instance.collection('tbStok').doc(docID).get();

  if (document.exists) {
    return true;
  } else {
    return false;
  }
}

class _AddBarangState extends State<AddBarang> {
  final namabarang = TextEditingController();
  final kategori = TextEditingController();
  final jumlah = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  var jumlahfirebase;

  bool exist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stor Barang"), centerTitle: true),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: namabarang,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Nama Barang"),
            ),
            SizedBox(height: 5),
            TextField(
                controller: kategori,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Kategori")),
            SizedBox(height: 20),
            TextField(
                controller: jumlah,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: "Jumlah")),
            SizedBox(height: 20),
            ElevatedButton.icon(
                style:
                    ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50)),
                onPressed: () async {
                  var dtBaru = StokBarang(
                    namabarang: namabarang.text,
                    kategori: kategori.text,
                    jumlah: jumlah.text,
                  );
                  var dtHistory = History(
                    nama: namabarang.text,
                    kategori: kategori.text,
                    jumlah: jumlah.text,
                    User: user.email.toString(),
                  );
                  if (checknotExist(dtBaru.namabarang) == false) {
                    Database.addData(item: dtBaru);
                    Database.addhistory(item: dtHistory);
                  } else {
                    print("Data sudah ada");
                  }
                  Navigator.pop(context);
                },
                icon: Icon(Icons.add),
                label: Text("Add to Firebase")),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
