import 'package:fcalc/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculator.dart';
import 'keycodes.dart';

class CalculatorBody extends StatelessWidget {

  CalculatorBody({Key? key}) : super(key: key);

  final _calculator = Calculator();

  @override
  Widget build(BuildContext context) => Focus(
    autofocus: true,
    onKey: _onKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: ValueListenableBuilder<String>(
            valueListenable: _calculator.displayNotifier,
            builder: (_, String value, __) => Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF158443),
              ),
            ),
          ),
        ),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: [
            Tile('7', _calculator.appendDigit),
            Tile('8', _calculator.appendDigit),
            Tile('9', _calculator.appendDigit),
            Tile('4', _calculator.appendDigit),
            Tile('5', _calculator.appendDigit),
            Tile('6', _calculator.appendDigit),
            Tile('1', _calculator.appendDigit),
            Tile('2', _calculator.appendDigit),
            Tile('3', _calculator.appendDigit),
            Tile('0', _calculator.appendDigit),
            Tile('+', (_) => _calculator.appendOperator(Operator.plus)),
            Tile('-', (_) => _calculator.appendOperator(Operator.minus)),
            Tile('AC', (_) => _calculator.clear()),
          ],
        ),
      ],
    ),
  );

  KeyEventResult _onKey(FocusNode node, RawKeyEvent event) {
    if (event.isDigit()) {
      _calculator.appendDigit(event.character!);
      return KeyEventResult.handled;
    } else if (event.isClear()) {
      _calculator.clear();
      return KeyEventResult.handled;
    } else if (event.character == '+') {
      _calculator.appendOperator(Operator.plus);
      return KeyEventResult.handled;
    } else if (event.character == '-') {
      _calculator.appendOperator(Operator.minus);
      return KeyEventResult.handled;
    } else if (event.isCopy()) {
      Clipboard.setData(ClipboardData(text: _calculator.displayNotifier.value));
      return KeyEventResult.handled;
    } else if (event.isPaste()) {
      Clipboard.getData(Clipboard.kTextPlain)
          .then((data) => _calculator.replaceDigits(data?.text));
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
