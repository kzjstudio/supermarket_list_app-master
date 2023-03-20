import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Item extends StatefulWidget {
  final String value;

  const Item({required this.value, super.key});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    var isChecked = false.obs;
    return Obx(() => Card(
          color: isChecked.isTrue ? Colors.grey.shade200 : Colors.white,
          elevation: 2,
          child: ListTile(
            leading: Text(
              widget.value,
              style: GoogleFonts.kalam(fontSize: 26, color: Colors.black),
            ),
            trailing: Obx(() => Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.black),
                  child: Checkbox(
                    activeColor: Colors.black,
                    focusColor: Colors.green,
                    value: isChecked.value,
                    onChanged: (bool? newvalue) {
                      isChecked.value = newvalue!;
                    },
                  ),
                )),
          ),
        ));
  }
}
