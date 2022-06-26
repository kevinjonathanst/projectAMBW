import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dbservices.dart';

class PageFilter extends StatefulWidget {
  const PageFilter({Key? key}) : super(key: key);

  @override
  State<PageFilter> createState() => _PageFilterState();
}

class _PageFilterState extends State<PageFilter> {
  final search = TextEditingController();
  final items = [];
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter Barang"), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          StreamBuilder<QuerySnapshot>(
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
                          print(lvkategori);
                          
                          if(lvkategori == search.toString()) {
                          return Card(
                            child: ListTile(
                              title: Text(lvnamabarang),
                              subtitle: Text(lvkategori),
                              trailing: Text(lvjumlah),
                              onTap: () {
                              },
                            ),
                          );
                          }
                          else {
                            return Card(
                              child: ListTile(
                                title: Text(""),
                                subtitle: Text(""),
                                trailing: Text(""),
                                onTap: () {
                                },
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8.0),
                        itemCount: snapshot.data!.docs.length);
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.pinkAccent,
                      ),
                    ),
                  );
                });
        },
        child: Icon(Icons.sort),
      ),
      body: Container(
        //create dropdownbutton
        decoration: BoxDecoration(),
        child: Column(
          children: [
            SizedBox(height: 40),
            TextField(
              controller: search,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(labelText: "Search..."),
            ),
            
          ],
        ),
      ),
    );
  }
}
