import 'package:e_commerce/config/app_module.dart';
import 'package:e_commerce/config/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
