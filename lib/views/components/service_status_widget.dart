import 'package:flutter/material.dart';
import '../../viewmodels/background_service_viewmodel.dart';
import 'package:provider/provider.dart';

class ServiceStatusWidget extends StatelessWidget {
  const ServiceStatusWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BackgroundServiceViewModel>(
      builder: (context, viewModel, _) {
        return Text(
          viewModel.appState.isBackgroundServiceRunning
              ? 'App is running in background'
              : 'App is not running in background',
          style: const TextStyle(fontSize: 18),
        );
      },
    );
  }
}
