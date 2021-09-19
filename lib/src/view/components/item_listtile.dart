import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  final Widget item;
  final Color cor;
  final String titulo;
  final String subtitulo;
  final IconData icone;

  const ItemList(
      {Key key,
      @required this.item,
      this.cor = Colors.blue,
      this.titulo = '',
      this.subtitulo = '',
      @required this.icone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icone,
        color: cor,
        size: 35,
      ),
      title: Text(
        this.titulo,
        style: TextStyle(color: cor, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitulo,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      trailing: Transform.scale(
        scale: 1.5,
        child: item,
      ),
    );
  }
}
