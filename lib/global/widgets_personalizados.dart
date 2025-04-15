import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/material.dart';

class PersonWidgets {

  static Widget criptoCard ({required CriptoCurrency cripto}) {
    return Card(
      child: ListTile(
        leading: Image.network(
          'https://assets.coingecko.com/coins/images/1/large/${cripto.name.toLowerCase()}.png',
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/cripto.png',
              fit: BoxFit.cover,
            );
          },
          width: 50,
          height: 50,
        ),
        title: Text(cripto.name),
        subtitle: Text(cripto.price.toString()),
        trailing: IconButton(
          tooltip: 'Adicionar aos favoritos',
          onPressed: (){}, 
          icon: Visibility(
            visible: cripto.favorito,
            replacement: Icon(Icons.star_border_outlined,),
            child: Icon(Icons.star, color: Colors.yellow,),
          ),
        ),
      ),
    );
  }

}