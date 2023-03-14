import 'package:demofirebase/pages/widget/select_multi_index_page.dart';
import 'package:flutter/material.dart';

class ListItem<T> {
  bool isSelected = false; //Selection property to highlight or not
  T data; //Data of the user
  ListItem(this.data); //Constructor to assign the data
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ListItem<String>> list;

  @override
  void initState() {
    super.initState();
    populateData();
  }

  void populateData() {
    list = [];
    for (int i = 0; i < 10; i++) {
      list.add(ListItem<String>("item $i"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("List Selection"),
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: _getListItemTile,
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        if (list.any((item) => item.isSelected)) {
          setState(() {
            list[index].isSelected = !list[index].isSelected;
          });
        }
      },
      onLongPress: () {
        setState(() {
          list[index].isSelected = true;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        color: list[index].isSelected ? Colors.red[100] : Colors.white,
        child: ListTile(
          title: Text(list[index].data),
        ),
      ),
    );
  }
}

// class SelectListItem extends StatefulWidget {
//   const SelectListItem({Key? key}) : super(key: key);
//
//   @override
//   _SelectListItemState createState() => _SelectListItemState();
// }
//
// class _SelectListItemState extends State<SelectListItem> {
//   final List<int> _selectedItems = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Select List Items'),
//         ),
//         body: ListView.builder(
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return Container(
//               color: (_selectedItems.contains(index))
//                   ? Colors.blue.withOpacity(0.5)
//                   : Colors.transparent,
//               child: ListTile(
//                 onTap: () {
//                   if (_selectedItems.contains(index)) {
//                     setState(() {
//                       _selectedItems.removeWhere((val) => val == index);
//                     });
//                   } else {
//                     setState(() {
//                       _selectedItems.add(index);
//                     });
//                   }
//                   print("----->_selectedItems ${_selectedItems.length}");
//                 },
//                 // onLongPress: () {
//                 //   if (!_selectedItems.contains(index)) {
//                 //     setState(() {
//                 //       _selectedItems.add(index);
//                 //     });
//                 //   }
//                 // },
//                 title: Text('$index'),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class SelectListItem extends StatefulWidget {
  const SelectListItem({Key? key}) : super(key: key);

  @override
  _SelectListItemState createState() => _SelectListItemState();
}

class _SelectListItemState extends State<SelectListItem> {
  List<Map> listItem = MyData.data;
  final List<int> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select List Items'),

        ),
        body: ListView.builder(
          itemCount: listItem.length,
          itemBuilder: (context, index) {
            return Container(
              color: (_selectedItems.contains(index))
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.transparent,
              child: ListTile(
                onTap: () {
                  if (_selectedItems.contains(index)) {
                    setState(() {
                      _selectedItems.removeWhere((val) => val == index);
                    });
                  } else {
                    setState(() {
                      _selectedItems.add(index);
                    });
                  }
                  print("----->_selectedItems ${_selectedItems.length}");
                },
                // onLongPress: () {
                //   if (!_selectedItems.contains(index)) {
                //     setState(() {
                //       _selectedItems.add(index);
                //     });
                //   }
                // },
                title: Text('${listItem[index]['name']}'),
              ),
            );
          },
        ),
      ),
    );
  }
}