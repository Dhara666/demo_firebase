import 'package:demofirebase/pages/geolocation_pages/place_service.dart';
import 'package:flutter/material.dart';

class AddressDialogPage extends StatefulWidget {
  final sessionToken;

  const AddressDialogPage({Key? key, this.sessionToken}) : super(key: key);

  @override
  AddressDialogPageState createState() => AddressDialogPageState();
}

class AddressDialogPageState extends State<AddressDialogPage> {
  TextEditingController searchController = TextEditingController();
  String query = "";
  PlaceApiProvider? apiClient;

  @override
  void initState() {
    super.initState();
    apiClient = PlaceApiProvider(widget.sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return animatedDialogueWithTextFieldAndButton(context);
  }

  animatedDialogueWithTextFieldAndButton(context) {
    var mediaQuery = MediaQuery.of(context);
    return AnimatedContainer(
      padding: mediaQuery.viewInsets,
      duration: const Duration(milliseconds: 300),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(maxWidth: double.infinity),
                  padding:
                      EdgeInsets.only(top: 8, bottom: 8, left: 18, right: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      child: SafeArea(
                        child: Material(
                          color: Colors.white,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20, bottom: 10),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    GoogleMapString.yourLocation,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 15, right: 15),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme:
                                          ThemeData().colorScheme.copyWith(
                                                primary: Color(0xff7c476d),
                                              ),
                                    ),
                                    child: TextFormField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.search),
                                          hintText: " Search here.."),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter address.";
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        query = value;
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: FutureBuilder<List<Suggestion>>(
                                    future: query == ""
                                        ? null
                                        : apiClient!.fetchSuggestions(
                                            query,
                                            Localizations.localeOf(context)
                                                .languageCode),
                                    builder: (context, snapshot) => query == ''
                                        ? Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: const Text(GoogleMapString
                                                .enterYourAddress),
                                          )
                                        : snapshot.hasData
                                            ? ListView.builder(
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) =>
                                                    ListTile(
                                                   title: Text(
                                                      (snapshot.data![index])
                                                          .description),
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context,
                                                        snapshot.data![index]);
                                                  },
                                                ),
                                                itemCount: snapshot.data!.length,
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleMapString {
  static const String start = 'Start';
  static const String distance = 'DISTANCE';
  static const String sourceLocation = 'Source Location';
  static const String destination = 'Destination';
  static const String enterYourAddress = 'Enter your address';
  static const String yourLocation = 'Your Location';
}
