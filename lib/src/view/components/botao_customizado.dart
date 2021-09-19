import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotaoBackground extends StatelessWidget {
  final IconData icone;
  final Color cor1;
  final Color cor2;

  const BotaoBackground(
      {Key key,
      this.icone = FontAwesomeIcons.userCircle,
      this.cor1 = Colors.blue,
      this.cor2 = Colors.blueGrey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: -20,
              top: -20,
              child: FaIcon(
                icone,
                size: 150,
                color: Colors.white.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(4, 6),
              blurRadius: 10,
            ),
          ],
          gradient: LinearGradient(colors: <Color>[
            // Color(0xff536CF6),
            // Color(0xff66A9F2),
            this.cor1,
            this.cor2,
          ])),
    );
  }
}

class BotaoInfo extends StatelessWidget {
  final IconData icone;
  final Color cor1;
  final Color cor2;
  @required
  final String texto;
  @required
  final Function onPress;

  const BotaoInfo(
      {Key key, this.icone, this.cor1, this.cor2, this.texto, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPress,
      child: Stack(
        children: <Widget>[
          BotaoBackground(
            icone: this.icone,
            cor1: this.cor1,
            cor2: this.cor2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 40,
              ),
              FaIcon(
                this.icone,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  this.texto,
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
