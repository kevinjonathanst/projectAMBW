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

class _AddBarangState extends State<AddBarang> {
  final namabarang = TextEditingController();
  final kategori = TextEditingController();
  final jumlah = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;

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
                  getDoc(dtBaru.namabarang, dtBaru.kategori, dtBaru.jumlah, dtHistory.User);
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

Future getDoc(String namabarang_, String kategoribarang_, String jumlah_,
    String user_) async {
  var dtBaru = StokBarang(
    namabarang: namabarang_,
    kategori: kategoribarang_,
    jumlah: jumlah_,
  );
  var dtHistory = History(
      nama: namabarang_,
      kategori: kategoribarang_,
      jumlah: jumlah_,
      User: user_);
  var a = await FirebaseFirestore.instance
      .collection('tbStok')
      .doc(namabarang_)
      .get();
  if (a.exists) {
    print('Exists');
    return a;
  }
  if (!a.exists) {
      Database.addData(
        item: StokBarang(
            namabarang: dtBaru.namabarang,
            kategori: dtBaru.kategori,
            jumlah: dtBaru.jumlah));
    Database.addhistory(
        item: History(
            nama: dtHistory.nama,
            kategori: dtHistory.kategori,
            jumlah: "+" + dtHistory.jumlah,
            User: dtHistory.User));
    print('Not exists');
    return null;
  }
}
