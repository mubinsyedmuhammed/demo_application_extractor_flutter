import 'package:flutter/material.dart';
import '../../viewmodels/background_service_viewmodel.dart';
import 'package:provider/provider.dart';

class ServiceControlButton extends StatelessWidget {
  const ServiceControlButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BackgroundServiceViewModel>(
      builder: (context, viewModel, _) {
        return ElevatedButton(
          onPressed: viewModel.appState.isBackgroundServiceRunning
              ? viewModel.stopBackgroundService
              : viewModel.startBackgroundService,
          child: Text(
            viewModel.appState.isBackgroundServiceRunning
                ? 'Stop Background Service'
                : 'Start Background Service',
          ),
        );
      },
    );
  }
}
