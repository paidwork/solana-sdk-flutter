import 'dart:developer';

class WorkenException implements Exception {
  final String message;

  WorkenException({required this.message}) {
    log(message);
  }
}
