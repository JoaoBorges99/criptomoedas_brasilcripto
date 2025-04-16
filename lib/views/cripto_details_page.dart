import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:criptomoedas_brasilcripto/stores/details_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';


class CriptoDetailsPage extends StatefulWidget {
  final CriptoCurrency cripto;
  const CriptoDetailsPage({super.key, required this.cripto});

  @override
  State<CriptoDetailsPage> createState() => _CriptoDetailsPageState();
}

class _CriptoDetailsPageState extends State<CriptoDetailsPage> {

  final store = DetailStore();

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
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final spots = store.criptoPriceList.asMap().entries.map((entry) {
            final i = entry.key;
            final e = entry.value;
            return FlSpot(i.toDouble(), e.priceUsd);
          }).toList();

          final labels = store.criptoPriceList.map((e) => DateFormat.Hm().format(e.date)).toList();

          return Padding(
            padding: const EdgeInsets.all(16),
            child: LineChart(
              LineChartData(
                // minY: store.criptoPriceList.map((e) => e.priceUsd).reduce((a, b) => a < b ? a : b) - 100,
                // maxY: store.criptoPriceList.map((e) => e.priceUsd).reduce((a, b) => a > b ? a : b) + 100,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 100),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        int index = value.toInt();
                        if (index < 0 || index >= labels.length) return const SizedBox();
                        return Text(labels[index], style: const TextStyle(fontSize: 10));
                      },
                      interval: 1,
                    ),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: Colors.orange,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.orange.withValues(alpha: 0.2),
                    ),
                  ),
                ],
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: true),
              ),
            ),
          );
        },
      ),
    );
  }
}