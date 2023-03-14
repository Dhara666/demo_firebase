import 'package:flutter/material.dart';

class ChoiceChipPage extends StatefulWidget {
  const ChoiceChipPage({Key? key}) : super(key: key);

  @override
  _ChoiceChipPageState createState() => _ChoiceChipPageState();
}

class Tech {
  String label;
  Color color;

  Tech(this.label, this.color);
}

class _ChoiceChipPageState extends State<ChoiceChipPage> {
  int? selectedIndex;
  List<Tech> _chipsList = [
    Tech("Android", Colors.green),
    Tech("Flutter", Colors.black),
    Tech("Ios", Colors.deepOrange),
    Tech("Python", Colors.cyan),
    Tech("React Native", Colors.yellow)
  ];
  List<String> programmingList = [
    "Flutter",
    "Java",
    "PHP",
    "C++",
    "C",
    "Android"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Current page --> $runtimeType');
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text('Single Choice chip'),
          Container(
            margin: EdgeInsets.only(left: 10, top: 10),
            child: Wrap(
              spacing: -15,
              direction: Axis.horizontal,
              children: techChips(),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Multi Choice chip'),
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.only(),
            child: MultiSelectChip(
              reportList: programmingList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  // ignore: unnecessary_statements
                  selectedList;
                  //selectedProgrammingList = selectedList;
                });
              },
            ),
          ),
          // Text(
          //   selectedProgrammingList.join(", "),
          //   style: TextStyle(color: Colors.blue),
          // ),
        ],
      ),
    );
  }

  List<Widget> techChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: EdgeInsets.only(left: 21, right: 10),
        child: ChoiceChip(
          selectedColor: Color(0xffc79ebc),
          label: Text(_chipsList[i].label),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.grey,
          selected: selectedIndex == i,
          onSelected: (bool value) {
            setState(() {
              print(_chipsList[i].label);
              selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}

// ignore: must_be_immutable
class MultiSelectChip extends StatefulWidget {
  List<String>? reportList;
  Function(List<String>)? onSelectionChanged;

  MultiSelectChip({this.reportList, this.onSelectionChanged});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // ignore: deprecated_member_use
  List<String> selectedChoices = [];

  buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList?.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ChoiceChip(
          backgroundColor: Colors.grey,
          selectedColor: Color(0xffc79ebc),
          label: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged!(selectedChoices);
              selectedChoices.forEach((element) {
                print("object -->$element");
              });
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0),
      child: Wrap(
        spacing: -10,
        direction: Axis.horizontal,
        children: buildChoiceList(),
      ),
    );
  }
}

// Container(
//   margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
//   decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
//   height: 30,
//   child: Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//     child: SeekBar(),
//   ),
// ),
// List<String> selectedProgrammingList = List();
// MaterialButton(
//   child: Text("Multi Select Chip Click"),
//   onPressed: () => _showDialog(),
// ),

// _showDialog() {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Flutter Choice Chip"),
//           content: MultiSelectChip(
//             programmingList,
//             onSelectionChanged: (selectedList) {
//               setState(() {
//                 selectedProgrammingList = selectedList;
//               });
//             },
//           ),
//           actions: <Widget>[
//             // MaterialButton(
//             //   child: Text("Report"),
//             //   onPressed: () => Navigator.of(context).pop(),
//             // )
//           ],
//         );
//       });
// }
