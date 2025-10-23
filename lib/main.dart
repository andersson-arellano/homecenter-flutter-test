import 'package:flutter/material.dart';
import 'package:homecenter_flutter/core/app.dart';
import 'package:homecenter_flutter/core/dependencys/injection_get_it.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  di.init();

  runApp(const MainApp());
}