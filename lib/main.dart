import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:tuto_domain_driven_design/injection.dart';
import 'package:tuto_domain_driven_design/presentation/core/app_widget.dart';

Future<void> main() async {
  configurationInjection(Environment.prod);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(AppWidget());
}
