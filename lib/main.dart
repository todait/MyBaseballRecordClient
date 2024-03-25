import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:my_baseball_record/common/app_color.dart';
import 'package:my_baseball_record/page/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Home',
      theme: ThemeData(
          fontFamily: "Pretendard",
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: AppColor.graysBlack)),
      home: const IntroPage(),
    );
  }
}
