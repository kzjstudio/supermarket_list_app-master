import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supermarket_list_app/admod_services.dart';
import 'package:supermarket_list_app/item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var listOfItems = [].obs;

  TextEditingController controller = TextEditingController();

  late List<String>? items;

  late List<String> myList;

  var isLight = true;

  void getSavedList() async {
    final prefs = await SharedPreferences.getInstance();
    final listToPull = await prefs.getStringList("key");
    if (listToPull == null) {
      return;
    } else {
      print(listToPull);
      listOfItems.value = List.from(listToPull as Iterable);
    }
  }

  void deleteSaved() async {
    final prefs = await SharedPreferences.getInstance();
    listOfItems.clear();
    await prefs.remove("key");
  }

  BannerAd? _banner;

  _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: AdmobService.bannerAdUnitId!,
      listener: AdmobService.bannerListener,
      request: AdRequest(),
    )..load();
  }

  @override
  void initState() {
    getSavedList();
    _createBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Shopping List",
            style: GoogleFonts.kalam(fontSize: 28),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  deleteSaved();
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  Get.isDarkMode
                      ? Get.changeTheme(ThemeData.light())
                      : Get.changeTheme(ThemeData.dark());
                },
                icon: Icon(Icons.lightbulb)),
          ],
        ),
        body: Obx(() => listOfItems.isEmpty
            ? Center(
                child: Text(
                  "Add items to your list!",
                  style: GoogleFonts.kalam(fontSize: 32),
                ),
              )
            : SingleChildScrollView(
                child: Obx(() => Column(
                      children:
                          listOfItems.map((item) => Item(value: item)).toList(),
                    )))),
        floatingActionButton: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              Get.defaultDialog(
                  titleStyle: GoogleFonts.kalam(),
                  title: "Add to your list ",
                  content: TextField(
                    style: GoogleFonts.kalam(),
                    autofocus: true,
                    controller: controller,
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.close(0);
                        },
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.kalam(),
                        )),
                    TextButton(
                        onPressed: () async {
                          listOfItems.add(controller.text);
                          final prefs = await SharedPreferences.getInstance()
                              .then((value) {
                            myList = List.from(listOfItems);
                            value.setStringList("key", myList);
                            print("saved");
                            controller.clear();
                            Get.close(0);
                          });
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.kalam(),
                        ))
                  ]);
            },
          ),
        ),
        bottomNavigationBar: _banner == null
            ? Container()
            : Container(
                margin: EdgeInsets.only(bottom: 12),
                height: 53,
                child: AdWidget(ad: _banner!),
              ));
  }
}
