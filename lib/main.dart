import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/data/local/news_api_service.dart';
import 'package:news_app/screens/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService().init();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}
