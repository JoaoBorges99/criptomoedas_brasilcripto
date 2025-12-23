import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonWidgets {

  static Widget criptoCard ({required CriptoCurrency cripto, required void Function()? onTap, required void Function()? adicionarRemoverFavorito}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha:0.1),
            width: 1,
          ),
        ),
      ),      
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
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
              
              const SizedBox(width: 10,),
          
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 5,
                  children: [
                    Text(
                      cripto.name,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Visibility(
                      visible: cripto.symbol.isNotEmpty,
                      child: SelectableText(
                        cripto.symbol,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  spacing: 5,
                  children: [
                    Text(
                      'U\$D ${double.parse(cripto.price).toStringAsFixed(2).toString()}',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Visibility(
                      visible: cripto.changePercent24Hr.isNotEmpty,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            double.parse(cripto.changePercent24Hr).isNegative ?
                            Icons.trending_down
                            : Icons.trending_up,
                            color: double.parse(cripto.changePercent24Hr).isNegative ?
                            Colors.red
                            : Colors.green,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            double.parse(cripto.changePercent24Hr).toStringAsFixed(2).toString(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: double.parse(cripto.changePercent24Hr).isNegative ?
                              Colors.red
                              : Colors.green,                              
                            ),                            
                          )
                        ]
                      ),
                    )
                  ],
                ),
              ),              
          
              IconButton(
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
            ],
          ),
        ),
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