import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';
import 'package:language_picker/languages.dart';
import 'package:translator/translator.dart';

class SettingController extends GetxController {
  static SettingController get instance => Get.find();

  final homeController = Get.put(HomeController());

  final translator = GoogleTranslator();

  RxString language = ''.obs;
  RxString codeLanguage = ''.obs;

  RxString country = ''.obs;
  RxString codeCountry = ''.obs;
  
  final storage = GetStorage();

  final supportedLanguages = [
    Languages.english,
    Languages.indonesian,
    Languages.korean,
    
  ];

  Language selectedDropdownLanguage = Languages.indonesian;
  
  Language selectedDropdownCountry = Languages.indonesian;

  
}
