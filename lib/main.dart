import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_app/bindings/initial_bindings.dart';
import 'package:study_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:study_app/routes/route.dart';
import 'package:study_app/screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   InitialBindings().dependencies();
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // theme: Get.find<ThemeController>().lightTheme,
      getPages: Routes.getPages(),
      initialRoute: "/main",
    );
  }
}
