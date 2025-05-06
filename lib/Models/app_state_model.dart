class AppStateModel {
  final bool isBackgroundServiceRunning;
  
  AppStateModel({
    this.isBackgroundServiceRunning = false,
  });
  
  AppStateModel copyWith({
    bool? isBackgroundServiceRunning,
  }) {
    return AppStateModel(
      isBackgroundServiceRunning: isBackgroundServiceRunning ?? this.isBackgroundServiceRunning,
    );
  }
}