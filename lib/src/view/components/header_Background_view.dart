import 'package:flutter/material.dart';

class HeaderBackground extends StatelessWidget {
  final Color cor1;
  final Color cor2;
  final double altura;

  const HeaderBackground(
      {Key key,
      this.cor1 = Colors.blue,
      this.cor2 = Colors.blueGrey,
      this.altura = 250})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: altura,
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            this.cor1,
            this.cor2,
          ],
        ),
      ),
    );
  }
}
