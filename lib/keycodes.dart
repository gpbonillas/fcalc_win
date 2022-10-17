import 'package:flutter/services.dart';

const _deleteKeyId = 0x10000007F;
const _backspaceKeyId = 0x100000008;
const _cKeyId = 0x00000063;
const _vKeyId = 0x00000076;

extension KeyCodes on RawKeyEvent {
  bool isClear() =>
      logicalKey.keyId == _deleteKeyId || logicalKey.keyId == _backspaceKeyId;

  bool isDigit() {
    //1
    final codeUnit = character?.codeUnitAt(0) ?? 0;
    return codeUnit >= 0x30 && codeUnit <= 0x39;
  }

  bool isCopy() =>
      //2
  (isMetaPressed || isControlPressed) && logicalKey.keyId == _cKeyId;

  bool isPaste() =>
      (isMetaPressed || isControlPressed) && logicalKey.keyId == _vKeyId;
}
