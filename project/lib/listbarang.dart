import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dbservices.dart';

class listbarang extends StatefulWidget {
  const listbarang({ Key? key }) : super(key: key);

  @override
  State<listbarang> createState() => _listbarangState();
}

class _listbarangState extends State<listbarang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Barang"), centerTitle: true),
      body: StreamBuilder<QuerySnapshot>(
          stream: Database.getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    DocumentSnapshot dsStok = snapshot.data!.docs[index];
                    String lvnamabarang = dsStok["namabarang"];
                    String lvkategori = dsStok["kategori"];
                    String lvjumlah = dsStok["jumlah"];
                    return Container(
                      child: Card(
                        child: Column(children: <Widget>[
                          Text(lvnamabarang),
                          Text(lvkategori),
                          Text(lvjumlah),
                        ]),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 8.0),
                  itemCount: snapshot.data!.docs.length);
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.pinkAccent,
                ),
              ),
            );
          }),
    );
  }
}