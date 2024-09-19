import 'package:flutter/material.dart';

class ScrollControllerProvider extends ChangeNotifier {

  PageController _controller = PageController();

 PageController get controller=>_controller;

}