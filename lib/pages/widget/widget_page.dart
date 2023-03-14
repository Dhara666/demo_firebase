import 'package:demofirebase/pages/widget/expansion_tile_page.dart';
import 'package:demofirebase/pages/widget/number_steper_page.dart';
import 'package:demofirebase/pages/widget/page_view.dart';
import 'package:demofirebase/pages/widget/process_stepper.dart';
import 'package:demofirebase/pages/widget/refesh_indictor.dart';
import 'package:demofirebase/pages/widget/select_index_page.dart';
import 'package:flutter/material.dart';
import '../../common/app_appbar.dart';
import '../../common/app_button.dart';
import 'choice_chip.dart';
import 'circular_process_indicator.dart';
import 'curve_container.dart';
import 'custom_stepper_page.dart';
import 'file_download_page.dart';
import 'image_picker.dart';
import 'multi_index_select.dart';

class WidgetPage extends StatefulWidget {
  const WidgetPage({Key? key}) : super(key: key);

  @override
  State<WidgetPage> createState() => _WidgetPageState();
}

class _WidgetPageState extends State<WidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        isHome: true,
        showDrawer: false,
        title: "COMMON WIDGET",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppButton(
              buttonText: "Expansion Tile And DropdownButton",
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ExpansionTilePage()));
              },
            ),
            AppButton(
              buttonText: "select current index",
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SelectIndexPage()));
              },
            ),
            AppButton(
              buttonText: "select Multi index",
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SelectListItem()));
              },
            ),
            AppButton(
              buttonText: "Refresh Indicator",
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RefreshIndicatorPage()));
              },
            ),
            AppButton(
              buttonText: "Curve Container",
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CurveContainerPage()));
              },
            ),
            AppButton(
              buttonText: "Process Indicator",
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const CircularProcessIndicator()));
              },
            ),
            AppButton(
              buttonText: "Number Stepper",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NumberStepperPage()));
              },
            ),
            AppButton(
              buttonText: "Custom Stepper",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomStepperPage()));
              },
            ),
            AppButton(
              buttonText: "Process Stepper",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProcessStepperPage()));
              },
            ),
            AppButton(
              buttonText: "PageView Builder",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PageViewStepPage()));
              },
            ),         AppButton(
              buttonText: "Choice Chips",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChoiceChipPage()));
              },
            ),
            AppButton(
              buttonText: "File Download",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FileDownloadPage()));
              },
            ),         AppButton(
              buttonText: "MultiImage PickerPage",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImagePickerPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
