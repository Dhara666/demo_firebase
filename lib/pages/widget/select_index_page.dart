import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/app_appbar.dart';

class SelectIndexPage extends StatefulWidget {
  @override
  SelectIndexPageState createState() => SelectIndexPageState();
}

class SelectIndexPageState extends State<SelectIndexPage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        isHome: true,
        showDrawer: false,
      ),
      body : ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item: $index'),
            tileColor: selectedIndex == index ? Colors.blue : null,
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
          );
        },
      ),
    );
  }
}