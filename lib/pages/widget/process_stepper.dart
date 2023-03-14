import 'package:flutter/material.dart';
import 'package:progress_stepper/progress_stepper.dart';

class ProcessStepperPage extends StatefulWidget {
  const ProcessStepperPage({Key? key}) : super(key: key);

  @override
  State<ProcessStepperPage> createState() => _ProcessStepperPageState();
}

class _ProcessStepperPageState extends State<ProcessStepperPage> {
  int _chevronCounter = 0;
  int _customCounter = 0;

  void _incrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 5) {
        _chevronCounter++;
      }
    });
  }

  void _decrementChevronStepper() {
    setState(() {
      if (_chevronCounter != 0) {
        _chevronCounter--;
      }
    });
  }

  void _incrementCustomStepper() {
    setState(() {
      if (_customCounter != 3) {
        _customCounter++;
      }
    });
  }

  void _decrementCustomStepper() {
    setState(() {
      if (_customCounter != 0) {
        _customCounter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Process Stepper"),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ProgressStepper(
            width: MediaQuery.of(context).size.width,
            height: 25,
            currentStep: _chevronCounter,
            onClick: (int index) {
              setState(() {
                _chevronCounter = index;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _decrementChevronStepper,
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: _incrementChevronStepper,
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ProgressStepper(
            width: 200,
            height: 25,
            stepCount: 3,
            builder: (int index) {
              const double widthOfStep = 200.0 / 3.0;
              if (index == 1) {
                return ProgressStepWithArrow(
                  width: widthOfStep,
                  defaultColor: Colors.red,
                  progressColor: Colors.green,
                  wasCompleted: _customCounter >= index,
                  child: Center(
                    child: Text(
                      index.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }
              return ProgressStepWithChevron(
                width: widthOfStep,
                defaultColor: Colors.red,
                progressColor: Colors.green,
                wasCompleted: _customCounter >= index,
                child: Center(
                  child: Text(
                    index.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: _decrementCustomStepper,
                child: const Text(
                  '-1',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: _incrementCustomStepper,
                child: const Text(
                  '+1',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ), // This trailing comma makes auto-formatting nicer for build methods.
  );
}

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController pageController = PageController(initialPage: 0);
  int _i = 0;

  List<String> introScreenName = [
    'lib/assets/images/ONBOARDING-1.png',
    'lib/assets/images/ONBOARDING-2.png',
    'lib/assets/images/ONBOARDING-3.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: introScreenName.length,
            onPageChanged: (int value) {
              setState(() {
                _i = value;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return new Image.asset(
                introScreenName[index],
                fit: BoxFit.fill,
              );
            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => SignUpView(
                      //             authFormType: AuthFormType.signIn)));
                    },
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(left: 20),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Skip",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Typewriter"))),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            for (int i = 0; i < introScreenName.length; i++)
                              _i == i
                                  ? pageIndexIndicator(true)
                                  : pageIndexIndicator(false)
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // _controller.move(++_i,animation: true);
                      pageController.animateToPage(++_i,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeIn);
                      print(_i);
                      setState(() {});
                      if (_i == 3) {
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SignUpView(
                        //             authFormType: AuthFormType.signIn)));
                      }
                    },
                    child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(right: 10),
                        // padding: EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(_i == 2 ? "Done" : "Next",
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "Typewriter"))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget pageIndexIndicator(bool isCurrentPage) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 5),
    height: isCurrentPage ? 10.0 : 8.0,
    width: isCurrentPage ? 10.0 : 8.0,
    decoration: BoxDecoration(
      color: isCurrentPage ? Colors.white : Colors.black,
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
