import 'package:flutter/material.dart';
import '../common/app_text.dart';

class DemoPage extends StatefulWidget {
  final String? title;

  const DemoPage({Key? key, this.title}) : super(key: key);

  @override
  State<DemoPage> createState() => DemoPageState();
}

class DemoPageState extends State<DemoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title!)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            myText(),
          ],
        ));
  }

  myText() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: AppText(
          textAlign: TextAlign.center,
          text: widget.title,
          fontSize: 22,
        ),
      ),
    );
  }

}
