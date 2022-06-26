import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dataclass.dart';
import 'dbservices.dart';

class narikbarang extends StatefulWidget {
  final String namabarang;
  final String jumlah;
  final String kategori;
  const narikbarang({Key? key, required this.namabarang, required this.kategori, required this.jumlah}) : super(key: key);

  @override
  State<narikbarang> createState() => _narikbarangState();
}

class _narikbarangState extends State<narikbarang> {
  final jumlahtarik = TextEditingController();
  var total;
  var tambah;
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Narik Barang"), centerTitle: true),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Text("${widget.namabarang}"),
            SizedBox(height: 30),
            Text("${widget.kategori}"),
            SizedBox(height: 30),
            Text("Jumlah: ${widget.jumlah}"),
            SizedBox(height: 30),
            TextField(
              controller: jumlahtarik,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Jumlah barang yang mau ditarik/ditambah"),
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text("Tarik"),
              onPressed: () {
                total = int.parse(widget.jumlah) - int.parse(jumlahtarik.text);
                var dtBaru = StokBarang(
                    namabarang: widget.namabarang,
                    kategori: widget.kategori,
                    jumlah: total.toString(),
                  );
                  var dtHistory = History(
                    nama: widget.namabarang,
                    kategori: widget.kategori,
                    jumlah: "-" + jumlahtarik.text,
                    User: user.email.toString(),
                  );
                //kalo jumlahnya <=0 langsung delete
                Database.updateData(item: dtBaru);
                Database.addhistory(item: dtHistory);
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
              child: Text("Tambah"),
              onPressed: () {
                total = int.parse(widget.jumlah) + int.parse(jumlahtarik.text);
                var dtBaru = StokBarang(
                    namabarang: widget.namabarang,
                    kategori: widget.kategori,
                    jumlah: total.toString(),
                  );
                  var dtHistory = History(
                    nama: widget.namabarang,
                    kategori: widget.kategori,
                    jumlah: "+" + jumlahtarik.text,
                    User: user.email.toString(),
                  );
                //kalo jumlahnya <=0 langsung delete
                Database.updateData(item: dtBaru);
                Database.addhistory(item: dtHistory);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
