import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/filter.dart';
import 'package:project/listbarang.dart';
import 'dbservices.dart';
import 'history.dart';
import 'narikbarang.dart';
import 'storbarang.dart';
import 'filter.dart';

class PageFilter extends StatefulWidget {
  const PageFilter({Key? key}) : super(key: key);

  @override
  State<PageFilter> createState() => _PageFilterState();
}

class _PageFilterState extends State<PageFilter> {
  final search = TextEditingController();
  final items = [];
  String name = " ";
  String? value;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference barang = FirebaseFirestore.instance.collection('tbStok');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Card(
        child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Search Category...',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            }),
      )),
      body: StreamBuilder<QuerySnapshot>(
          stream: (name != " " && name != null)
              ? FirebaseFirestore.instance
                  .collection('tbStok')
                  .where('kategori', isEqualTo: name)
                  .snapshots()
              : FirebaseFirestore.instance.collection("tbStok").snapshots(),
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
                    return Card(
                      child: ListTile(
                        title: Text(lvnamabarang),
                        subtitle: Text(lvkategori),
                        trailing: Text(lvjumlah),
                        onTap: () {},
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
