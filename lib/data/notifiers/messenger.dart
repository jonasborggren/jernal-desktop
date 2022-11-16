import 'dart:async';

import 'package:flutter/material.dart';

class MessageNotifier extends ChangeNotifier {
  final List<Message> _messages = [];

  Message? message;
  Timer? timer;

  void show({
    required String title,
    String? summary,
  }) {
    _messages.clear();
    timer?.cancel();
    message = null;
    notifyListeners();
    _messages.add(Message(title: title, summary: summary));
    _showNextMessage();
  }

  void queue({
    required String title,
    String? summary,
  }) {
    _messages.add(Message(title: title, summary: summary));
    _showNextMessage();
  }

  void _showNextMessage() {
    if (message == null) {
      if (_messages.isNotEmpty) {
        message = _messages.first;
        notifyListeners();

        timer = Timer(const Duration(milliseconds: 1500), () {
          _messages.removeAt(0);
          message = null;
          notifyListeners();
          _showNextMessage();
        });
      } else {
        message = null;
        notifyListeners();
      }
    }
  }
}

class Message {
  Message({required this.title, required this.summary});
  final String title;
  final String? summary;
}
