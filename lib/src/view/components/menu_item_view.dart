import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key key,
    @required this.img,
    @required this.header,
    @required this.botton,
    @required this.onPress,
    this.cor = Colors.blue,
  }) : super(key: key);

  final String img;
  final String header;
  final String botton;
  final Function onPress;
  final Color cor;

  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.only(top: 5, right: 10, left: 10),
        child: InkWell(
          splashColor: cor,
          onTap: () {
            onPress();
          },
          child: Row(
            children: <Widget>[
              /*  Image(
                image: AssetImage(img.toString()),
                fit: BoxFit.cover,
                height: 75,
                width: 75,
              ),  */
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    header.toString(),
                    style: GoogleFonts.lato(
                      color: Color(0xff317183),
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    botton.toString(),
                    style: GoogleFonts.lato(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
