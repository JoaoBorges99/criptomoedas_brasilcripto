import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonWidgets {

  static Widget criptoCard ({required CriptoCurrency cripto, required void Function()? onTap, required void Function()? adicionarRemoverFavorito}) {
    return Card(
      child: ListTile(
        leading: Image.network(
          // 'https://assets.coingecko.com/coins/images/1/large/${cripto.name.toLowerCase()}.png',
          'https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/32/${cripto.id.toLowerCase()}.png',
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
          onPressed: (){
            adicionarRemoverFavorito!();
            cripto.adicionarRemoverFavorito();
          }, 
          icon: Visibility(
            visible: cripto.favorito,
            replacement: Icon(Icons.star_border_outlined,),
            child: Icon(Icons.star, color: Colors.yellow,),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  static Widget buildCryptoDetailsHeader({required String imageUrl,required CriptoCurrency cripto}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícone da moeda
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.network(
              imageUrl,
              errorBuilder: (_, __, ___) => const Icon(Icons.currency_bitcoin, color: Colors.white),
            ),
          ),
          const SizedBox(width: 16),

          // Nome + data
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${cripto.name} (${cripto.symbol})',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(DateFormat('d MMMM yyyy').format(DateTime.now()),),
              ],
            ),
          ),

          // Dados da moeda
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _infoRow('PRICE', double.tryParse(cripto.price)!.toStringAsFixed(2)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _infoRow(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

}