// lib/views/home_view.dart
import 'package:demo_application_extractor_ui/viewmodels/background_service_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    // Initialize service on app start
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<BackgroundServiceViewModel>(context, listen: false);
      await viewModel.initializeService();
    });
  }
  
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final viewModel = Provider.of<BackgroundServiceViewModel>(context, listen: false);
    
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        if (viewModel.appState.isBackgroundServiceRunning) {
          viewModel.startBackgroundService();
        }
        break;
      case AppLifecycleState.resumed:
        // Optional: Handle resume state
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background App Demo'),
      ),
      body: Consumer<BackgroundServiceViewModel>(
        builder: (context, viewModel, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  viewModel.appState.isBackgroundServiceRunning
                      ? 'App is running in background'
                      : 'App is not running in background',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: viewModel.appState.isBackgroundServiceRunning
                      ? viewModel.stopBackgroundService
                      : viewModel.startBackgroundService,
                  child: Text(
                    viewModel.appState.isBackgroundServiceRunning
                        ? 'Stop Background Service'
                        : 'Start Background Service',
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Minimize the app to see the floating message',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
