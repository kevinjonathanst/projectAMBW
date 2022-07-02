import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/dataclass.dart';
import 'package:project/filter.dart';
import 'package:project/listbarang.dart';
import 'dbservices.dart';
import 'history.dart';
import 'narikbarang.dart';
import 'storbarang.dart';
import 'filter.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  String name = " ";
  final user = FirebaseAuth.instance.currentUser!;
  final search = TextEditingController();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => homePage()),
        // );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddBarang()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => history()),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Card(
        child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              hintText: 'Search nama...',
            ),
            onChanged: (val) {
              setState(() {
                name = val;
              });
            }), 
            
      )),
      //create a button on top of the screen
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PageFilter()),
          );
        },
        child: Icon(Icons.search),
      ),
      body: StreamBuilder<QuerySnapshot>(
              stream: (name != " " && name != null)
              ? FirebaseFirestore.instance
                  .collection('tbStok')
                  .where('namabarang', isEqualTo: name)
                  .snapshots():
              FirebaseFirestore.instance.collection("tbStok").snapshots(),
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
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => narikbarang()),
                              // );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => narikbarang(
                                      namabarang: lvnamabarang,
                                      kategori: lvkategori,
                                      jumlah: lvjumlah)));
                            },
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
            
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Stor Barang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
