import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';
import 'package:kolink_news/view/setting/controller/setting_controller.dart';
import 'package:language_picker/language_picker_dialog.dart';
import 'package:language_picker/languages.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Settings',
          style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.blue[700]),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "News Language",
                      style: TextStyle(fontSize: 16),
                    )),
                    MaterialButton(
                      color: Colors.grey.shade200,
                      child: Obx(() {
                        return Text(controller.language.isEmpty
                            ? (controller.storage.read("LANGUAGE") == null)
                                ? "Indonesia"
                                : controller.storage.read("LANGUAGE")
                            : controller.storage.read("LANGUAGE"));
                      }),
                      onPressed: () {
                        _openLanguagePickerDialog("Select Language", 0);
                        // controller.translateToKor();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                        child: Text(
                      "News Country",
                      style: TextStyle(fontSize: 16),
                    )),
                    MaterialButton(
                      color: Colors.grey.shade200,
                      child: Obx(() {
                        return Text(controller.country.isEmpty
                            ? (controller.storage.read("COUNTRY") == null)
                                ? "Indonesia"
                                : controller.storage.read("COUNTRY")
                            : controller.storage.read("COUNTRY"));
                      }),
                      onPressed: () {
                        _openLanguagePickerDialog("Select Country", 1);
                        // controller.translateToKor();
                      },
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  // It's sample code of Dropdown Item.
  // Widget _buildDropdownItem(Language language) {
  //   return Row(
  //     children: <Widget>[
  //       const SizedBox(
  //         width: 8.0,
  //       ),
  //       Text("${language.name} (${language.isoCode})"),
  //     ],
  //   );
  // }

  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name),
          const SizedBox(width: 8.0),
          Flexible(child: Text("(${language.isoCode})"))
        ],
      );

  void _openLanguagePickerDialog(String text, int isCountry) => showDialog(
        context: Get.context!,
        builder: (context) => Theme(
            data:
                Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
            child: LanguagePickerDialog(
                languages: controller.supportedLanguages,
                titlePadding: const EdgeInsets.all(8.0),
                searchCursorColor: Colors.pinkAccent,
                searchInputDecoration:
                    const InputDecoration(hintText: 'Search...'),
                isSearchable: true,
                title: Text(text),
                onValuePicked: (Language language) async {
                  if (isCountry == 0) {
                    controller.selectedDropdownLanguage = language;
                    controller.language.value = controller.selectedDropdownLanguage.name;
                    controller.codeLanguage.value =  controller.selectedDropdownLanguage.isoCode;

                    controller.storage.write("CODELANGUAGE", controller.selectedDropdownLanguage.isoCode);

                    controller.storage.write(
                        "LANGUAGE", controller.selectedDropdownLanguage.name);
                    print('0------');
                    print(controller.storage.read("CODELANGUAGE"));
                    Get.delete<HomeController>();
                  } else if (isCountry == 1) {
                    controller.selectedDropdownCountry = language;
                    controller.country.value = controller.selectedDropdownCountry.name;
                    controller.codeCountry.value = controller.selectedDropdownCountry.isoCode;
                    controller.storage.write("CODECOUNTRY", controller.selectedDropdownCountry.isoCode);
                    controller.storage.write(  "COUNTRY", controller.selectedDropdownCountry.name);
                    print('1------');
                    print(controller.storage.read("CODECOUNTRY"));
                    Get.delete<HomeController>();
                  }
                },
                itemBuilder: _buildDialogItem)),
      );
}
