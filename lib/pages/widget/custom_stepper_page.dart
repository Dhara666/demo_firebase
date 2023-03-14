import 'package:flutter/material.dart';
import '../demo_page.dart';

class CustomStepper extends StatelessWidget {
  final double width;
  final List<IconData> icons;
  final List<String> titles;
  final int curStep;
  final Color circleActiveColor;
  final Color circleInactiveColor;

  final Color iconActiveColor;
  final Color iconInactiveColor;

  final Color textActiveColor;
  final Color textInactiveColor;
  final double lineWidth = 4.0;

  final List<Widget> content;

  const CustomStepper(
      { required this.icons,
        required this.curStep,
        required this.titles,
        required this.width,
        required this.circleActiveColor,
        required this.circleInactiveColor,
        required this.iconActiveColor,
        required this.iconInactiveColor,
        required this.textActiveColor,
        required this.textInactiveColor,
        required this.content,
        super.key})
      : assert(curStep > 0 && curStep <= icons.length),
        assert(width > 0);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // textDirection: TextDirection.rtl,
      textDirection: TextDirection.ltr,
      child: Container(
          width: width,
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 24.0,
            right: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: _iconViews(),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _titleViews(),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: content[curStep - 1]),
              )
            ],
          )),
    );
  }

  List<Widget> _iconViews() {
    var list = <Widget>[];
    icons.asMap().forEach((i, icon) {
      var circleColor = (i == 0 || curStep >= i + 1)
          ? circleActiveColor
          : circleInactiveColor;

      var lineColor = (i == 0 || curStep >= i + 1)
          ? circleActiveColor
          : circleInactiveColor;

      var iconColor =
      (i == 0 || curStep >= i + 1) ? iconActiveColor : iconInactiveColor;

      list.add(
        Container(
          width: 50.0,
          height: 50.0,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: circleColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 25.0,
          ),
        ),
      );

      //line between icons
      if (i != icons.length - 1) {
        list.add(Expanded(
            child: Container(
              height: lineWidth,
              color: lineColor,
            )));
      }
    });

    return list;
  }

  List<Widget> _titleViews() {
    var list = <Widget>[];
    titles.asMap().forEach((i, text) {
      var textColor =
      (i == 0 || curStep > i + 1) ? textActiveColor : textInactiveColor;

      list.add(
        Container(
          width: 60.0,
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.all(0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor,fontSize: 10.5),
          ),
        ),
      );
    });
    return list;
  }
}

class CustomStepperPage extends StatefulWidget {
  const CustomStepperPage({Key? key}) : super(key: key);

  @override
  State<CustomStepperPage> createState() => CustomStepperPageState();
}

class CustomStepperPageState extends State<CustomStepperPage> {
  static const _stepIcons = [
    Icons.account_circle,
    Icons.shopping_cart_rounded,
    Icons.payment,
    Icons.paypal,
  ];
  static const _titles = [
    'Registration',
    'Shopping Cart',
    'CheckOut',
    'Payment'
  ];
  final List<DemoPage> content = [
    const DemoPage(title: "Registration"),
    const DemoPage(title: "Shopping Cart"),
    const DemoPage(title: "CheckOut"),
    const DemoPage(title: "Payment"),
  ];

  var _curStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Stepper'),
        centerTitle: true,
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    padding: const EdgeInsets.all(16)),
                onPressed: () => setState(() {
                  if (_curStep > 1) _curStep--;
                }),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                onPressed: () => setState(() {
                  if (_curStep < _stepIcons.length) _curStep++;
                }),
                child: const Text('Next'),
              ),
            ),
          ],
        )
      ],
      body: CustomStepper(
        icons: _stepIcons,
        width: MediaQuery.of(context).size.width,
        curStep: _curStep,
        titles: _titles,
        circleActiveColor: Colors.green,
        circleInactiveColor: const Color(0xffD5D5D5),
        iconActiveColor: Colors.white,
        iconInactiveColor: Colors.white,
        textActiveColor: Colors.green,
        textInactiveColor: const Color(0xffD5D5D5),
        content: content,
      ),
    );
  }
}