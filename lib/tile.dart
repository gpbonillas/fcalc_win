import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String symbol;
  final Function(String) onTap;

  const Tile(
      this.symbol,
      this.onTap, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) => Material(
    child: InkWell(
      //1
      onTap: () => onTap(symbol),
      //2
      child: Center(
        child: Text(
          symbol,
          style: const TextStyle(
            fontSize: 26,
            color: Color(0xFF333333), //grey
          ),
        ),
      ),
    ),
    color: const Color(0xFFFCB526), //yellow
  );
}
