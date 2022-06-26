

import 'package:flutter/material.dart';

class PageFilter extends StatefulWidget {
  const PageFilter({ Key? key }) : super(key: key);

  @override
  State<PageFilter> createState() => _PageFilterState();

}

class _PageFilterState extends State<PageFilter> {
  final items = ['items1', 'items2', 'items3', 'items4', 'items5'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter Barang"), centerTitle: true),
      body: Center(
        //create dropdown button that contains list
        // child: DropdownButton<String>(
        //   items: items.map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // ),
      ),
    );
  }
}