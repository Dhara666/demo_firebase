import 'package:demofirebase/common/app_appbar.dart';
import 'package:demofirebase/common/app_button.dart';
import 'package:demofirebase/pages/demo_page.dart';
import 'package:flutter/material.dart';

class PageViewStepPage extends StatefulWidget {
  const PageViewStepPage({Key? key}) : super(key: key);

  @override
  State<PageViewStepPage> createState() => PageViewStepPageState();
}

class PageViewStepPageState extends State<PageViewStepPage> {
  int currentStep = 1;

  List<Widget> _buildStep() {
    switch (currentStep) {
      case 1:
        return <Widget>[const DemoPage(title: "DemoPage 1")];
      case 2:
        return <Widget>[const DemoPage(title: "DemoPage 2")];
      case 3:
        return <Widget>[const DemoPage(title: "DemoPage 3")];
      case 4:
        return <Widget>[const DemoPage(title: "DemoPage 4")];
      default:
        return <Widget>[Container()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar(title: "STEPPER", isHome: false, showDrawer: false),
        body: Stack(
          alignment: Alignment.bottomCenter,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ..._buildStep(),
            Row(
              children: [
                if (currentStep > 1)
                  Expanded(
                    child: AppButton(
                      onTap: () {
                        onPressedBack();
                      },
                      buttonText: 'Back',
                    ),
                  ),
                Expanded(
                  child: AppButton(
                    buttonText: currentStep >= 5 ? 'Done' : 'Next',
                    onTap: () {
                      onPressedNext();
                    },
                    // isDisabled: controller.isNextDisabled,
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void onPressedBack() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  void onPressedNext() {
    if (currentStep >= 5) {
      Navigator.pop(context);
    } else {
      setState(() {
        currentStep++;
      });
    }
  }
}


