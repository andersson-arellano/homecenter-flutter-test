import 'package:flutter/material.dart';
import 'package:homecenter_flutter/core/theme/light.dart';
import 'package:homecenter_flutter/features/products/presentation/pages/product_page.dart';

class MainApp extends StatelessWidget{
  
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: ProductPage(),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false, 
    );
  }
}