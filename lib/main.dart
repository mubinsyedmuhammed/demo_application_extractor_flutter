import 'package:demo_application_extractor_ui/viewmodels/background_service_viewmodel.dart';
import 'package:demo_application_extractor_ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BackgroundServiceViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Background Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
    );
  }
}
