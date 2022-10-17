import 'package:flutter/material.dart';

enum Operator { plus, minus }

class Calculator {
  final displayNotifier = ValueNotifier('0');

  Operator? _pendingOperation;
  int? _operand;
  bool _wasDigitJustAppended = false;

  void appendOperator(Operator operation) {
    if (_wasDigitJustAppended) {
      //1
      switch (_pendingOperation) {
        case Operator.plus:
          _updateDisplay(_operand! + int.parse(displayNotifier.value));
          break;
        case Operator.minus:
          _updateDisplay(_operand! - int.parse(displayNotifier.value));
          break;
      //2
        case null:
          _operand = int.parse(displayNotifier.value);
          break;
      }
    }
    _wasDigitJustAppended = false;
    //3
    _pendingOperation = operation;
  }

  void _updateDisplay(int result) {
    _operand = result;
    displayNotifier.value = result.toString();
  }

  void appendDigit(String digit) {
    //4
    if (!_wasDigitJustAppended) {
      displayNotifier.value = '';
    }
    //5
    _wasDigitJustAppended = true;
    displayNotifier.value += digit;
  }

  void replaceDigits(String? possibleDigits) {
    if (possibleDigits != null && int.tryParse(possibleDigits) != null) {
      _wasDigitJustAppended = true;
      displayNotifier.value = possibleDigits;
    }
  }

  void clear() {
    _pendingOperation = null;
    _operand = null;
    _wasDigitJustAppended = false;
    displayNotifier.value = '0';
  }
}
