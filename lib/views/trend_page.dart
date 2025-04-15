import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TrendPage extends StatefulWidget {
  const TrendPage({super.key});

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> {

  List<CriptoCurrency> teste = [
    CriptoCurrency(id: '1', name: 'Bitcoin', symbol: 'BTC', price: '50000', favorito: true),
    CriptoCurrency(id: '2', name: 'Ethereum', symbol: 'ETH', price: '4000'),
    CriptoCurrency(id: '3', name: 'Ripple', symbol: 'XRP', price: '1'),
    CriptoCurrency(id: '4', name: 'Litecoin', symbol: 'LTC', price: '200'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(10),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: PageController(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        child: Center(child: Text('Item ${index + 1}')),
                      ),
                    );
                  },
                ),
              ),
            ),
            Card(
              child: ExpansionTile(
                initiallyExpanded: true,
                leading: Icon(Icons.local_fire_department, color: Colors.deepOrange,),
                title: Text("TOP 10 Trending Criptos"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                trailing: SizedBox(),
                children: teste.map((e){
                  return Observer(
                    builder: (_) => PersonWidgets.criptoCard(
                      cripto: e,
                      onTap: () {},
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        )
      ),
    );
  }
}