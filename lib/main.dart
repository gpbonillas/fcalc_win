import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

import 'calculator_body.dart';

Future<void> main() async {
  //1
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  //2
  await windowManager.setMinimumSize(const Size(309, 600));
  await windowManager.setMaximumSize(const Size(618, 1200));
  await windowManager.setSize(const Size(309, 600));
  await windowManager.setAspectRatio(0.54);
  await windowManager.setMaximizable(false);
  await windowManager.setTitle('FCalc');

  //3
  runApp(const FCalcApp());
}

class FCalcApp extends StatelessWidget {
  const FCalcApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: CalculatorBody()));
}
