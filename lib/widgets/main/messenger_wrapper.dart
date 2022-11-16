import 'package:flutter/material.dart';
import 'package:jernal/data/notifiers/messenger.dart';
import 'package:jernal/utils/extensions.dart';
import 'package:provider/provider.dart';

class MessengerWrapper extends StatelessWidget {
  const MessengerWrapper({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageNotifier>(
      builder: (context, notifier, _) => Stack(
        alignment: AlignmentDirectional.topEnd,
        children: [
          child,
          MessageView(message: notifier.message),
        ],
      ),
    );
  }
}

Message? _lastMessage;

class MessageView extends StatelessWidget {
  const MessageView({super.key, required this.message});

  final Message? message;

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      _lastMessage = message!;
    }
    if (_lastMessage == null) return Container();
    return AnimatedOpacity(
      duration: Duration(milliseconds: message != null ? 100 : 1000),
      opacity: message != null ? 1.0 : 0.0,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.onSurface.withOpacity(0.05),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          _lastMessage?.summary != null
              ? "${_lastMessage?.title}: ${_lastMessage?.summary}"
              : _lastMessage?.title ?? "Error",
          style: context.theme.textTheme.bodySmall?.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
