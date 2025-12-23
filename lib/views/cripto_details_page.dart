import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:criptomoedas_brasilcripto/stores/details_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fl_chart/fl_chart.dart';


class CriptoDetailsPage extends StatefulWidget {
  final CriptoCurrency cripto;
  const CriptoDetailsPage({super.key, required this.cripto});

  @override
  State<CriptoDetailsPage> createState() => _CriptoDetailsPageState();
}

class _CriptoDetailsPageState extends State<CriptoDetailsPage> {

  DetailStore store = DetailStore();

  @override
  void initState() {
    super.initState();
    store.getCriptoPrice(cripto: widget.cripto);
  }

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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 15, 23, 42),
              Color.fromARGB(255, 42, 44, 199),
              Color.fromARGB(255, 28, 35, 135),
              Color.fromARGB(255, 15, 23, 42),
            ]
          )  
        ),        
        child: Column(
          children: [
            PersonWidgets.buildCryptoDetailsHeader(
              cripto: widget.cripto, 
              imageUrl:'https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/32/${widget.cripto.id.toLowerCase()}.png',
            ),
        
            Observer(
              builder: (_) {
                if (store.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
            
                final spots = store.criptoPriceList.asMap().entries.map((entry) {
                  final index = entry.key.toDouble(); // Eixo X será o índice
                  final price = entry.value.price; // Eixo Y
                  return FlSpot(index, double.parse(price.toStringAsFixed(2)));
                }).toList();
            
                // Mapeia índice -> data formatada
                final labels = {
                  for (var i = 0; i < store.criptoPriceList.length; i++)
                    i.toDouble(): store.criptoPriceList[i].formattedDate,
                };
            
                return Container(
                  height: 300,
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            color: Colors.green,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.green.withValues(alpha: 0.2),
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 60,
                              getTitlesWidget: (value, meta) {
                                final text = labels[value];
                                return Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: Transform.rotate(
                                    angle: -0.7,
                                    child: Text(text ?? '', style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}