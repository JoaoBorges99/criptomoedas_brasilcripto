import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesPage extends StatefulWidget {
  final MainStore mainController;

  const FavoritesPage({super.key, required this.mainController});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(
          builder: (_) => Column(
            children: widget.mainController.favListItens.map( (e) =>
              PersonWidgets.criptoCard(
                cripto: e,
                onTap: () {},
              ),
            ).toList(),
          ),
        ),
      ),
    );
  }
}