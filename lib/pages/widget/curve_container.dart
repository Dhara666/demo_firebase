import 'package:flutter/material.dart';

class CurveContainerPage extends StatefulWidget {
  const CurveContainerPage({Key? key}) : super(key: key);

  @override
  State<CurveContainerPage> createState() => CurveContainerPageState();
}

class CurveContainerPageState extends State<CurveContainerPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          elevation: 0.0,
        ),
        backgroundColor: Colors.yellow,
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
                    )),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: 40,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
                        child: const Text('Sign in',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
