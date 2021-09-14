import 'package:flutter/material.dart';
import 'header_Background_view.dart';

class IconeHeader extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final Color cor1;
  final Color cor2;
  final double altura;

  const IconeHeader(
      {@required this.icone,
      @required this.titulo,
      this.cor1 = Colors.blue,
      this.cor2 = Colors.blueGrey,
      this.altura = 230});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        HeaderBackground(
          cor1: this.cor1,
          cor2: this.cor2,
          altura: altura,
        ),
        Positioned(
          top: -70,
          left: -70,
          child: Icon(
            this.icone,
            size: 230,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 80,
              width: double.infinity,
            ),
            Text(
              this.titulo.toString(),
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Icon(
              this.icone,
              size: 80,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
