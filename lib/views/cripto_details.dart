import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CriptoDetails extends StatefulWidget {
  final CriptoCurrency cripto;
  const CriptoDetails({super.key, required this.cripto});

  @override
  State<CriptoDetails> createState() => _CriptoDetailsState();
}

class _CriptoDetailsState extends State<CriptoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cripto.name),
        actions: [
          Observer(
            builder: (_) => IconButton(
              icon: Visibility(
                visible: widget.cripto.favorito,
                replacement: Icon(Icons.star_border_outlined,),
                child: Icon(Icons.star, color: Colors.yellow,),
              ),
              onPressed: () {
                widget.cripto.adicionarRemoverFavorito();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Cripto Details Page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}