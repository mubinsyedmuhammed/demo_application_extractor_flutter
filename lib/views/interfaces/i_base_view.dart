import 'package:flutter/material.dart';

abstract class IBaseView extends StatefulWidget {
  const IBaseView({super.key});
}

abstract class IBaseViewState<T extends IBaseView> extends State<T> {
  void initializeViewModel();
  void setupEventListeners();
}
