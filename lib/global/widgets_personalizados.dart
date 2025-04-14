import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/material.dart';

class PersonWidgets {

  static Widget criptoCard ({required CriptoCurrency cripto}) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://cryptologos.cc/logos/${cripto.symbol.toLowerCase()}-logo.png?v=022',
          width: 50,
          height: 50,
        ),
        title: Text(cripto.name),
        subtitle: Text(cripto.price.toString()),
        trailing: IconButton(
          tooltip: 'Adicionar aos favoritos',
          onPressed: (){}, 
          icon: Icon(Icons.star_border_outlined),
        ),
      ),
    );
  }

}