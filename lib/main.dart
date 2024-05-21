import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kolink_news/navigation_menu.dart';

void main() async {
  // Initialize WebView platform
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final GetStorage storage = GetStorage();
  if (storage.read("CODELANGUAGE") == null ||
      storage.read("CODELANGUAGE").toString().isEmpty || storage.read("CODECOUNTRY") == null) {
    storage.write("CODELANGUAGE", "id");
    storage.write("LANGUAGE", "indonesian");

    storage.write("CODECOUNTRY","id");
    storage.write("COUNTRY","indonesian");
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newsly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NavigationMenu(),
    );
  }
}
