

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dbservices.dart';

class history extends StatefulWidget {
  const history({ Key? key }) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("List Barang")),
      body: StreamBuilder<QuerySnapshot>(
          stream: Database.getDataHistory(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("error");
            } else if (snapshot.hasData || snapshot.data != null) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    DocumentSnapshot dsStok = snapshot.data!.docs[index];
                    String lvuser = dsStok['User'];
                    String lvnamabarang = dsStok["nama"];
                    String lvkategori = dsStok["kategori"];
                    String lvjumlah = dsStok["jumlah"];
                    return Container(
                      child: Card(
                        child: Column(children: <Widget>[
                          Text(lvuser),
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