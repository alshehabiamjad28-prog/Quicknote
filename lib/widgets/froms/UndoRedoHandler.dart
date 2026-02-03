import 'dart:async';
import 'package:flutter/material.dart';

class UndoRedoHandler {
  final TextEditingController controller;
  List<String> _history = [];
  int _currentIndex = -1;
  Timer? _timer;

  UndoRedoHandler(this.controller) {
    _saveState();
  }

  void _saveState() {
    if (_currentIndex < _history.length - 1) {
      _history = _history.sublist(0, _currentIndex + 1);
    }
    _history.add(controller.text);
    _currentIndex++;
  }

  void onTextChanged() {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: 500), _saveState);
  }

  void undo() {
    if (_currentIndex > 0) {
      _currentIndex--;
      controller.text = _history[_currentIndex];
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
    }
  }

  void redo() {
    if (_currentIndex < _history.length - 1) {
      _currentIndex++;
      controller.text = _history[_currentIndex];
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );
    }
  }

  void dispose() {
    _timer?.cancel();
  }
}