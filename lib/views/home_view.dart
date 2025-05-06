// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/background_service_viewmodel.dart';
import 'interfaces/i_base_view.dart';
import 'components/service_status_widget.dart';
import 'components/service_control_button.dart';

class HomeView extends IBaseView {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends IBaseViewState<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeViewModel();
    setupEventListeners();
  }

  @override
  void initializeViewModel() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final viewModel = Provider.of<BackgroundServiceViewModel>(context, listen: false);
      await viewModel.initializeService();
    });
  }

  @override
  void setupEventListeners() {
    // Add any additional event listeners here
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            ServiceStatusWidget(),
            SizedBox(height: 20),
            ServiceControlButton(),
            SizedBox(height: 20),
            Text(
              'Minimize the app to see the floating message',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
