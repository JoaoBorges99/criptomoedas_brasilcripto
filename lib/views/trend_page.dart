import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TrendPage extends StatefulWidget {
  final MainStore mainController;
  const TrendPage({super.key, required this.mainController});

  @override
  State<TrendPage> createState() => _TrendPageState();
}

class _TrendPageState extends State<TrendPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    widget.mainController.getAllTrendCripto(newList: widget.mainController.criptoCurrencyTrendList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => Visibility(
            visible: widget.mainController.criptoCurrencyTrendList.isNotEmpty && !widget.mainController.isLoading,
            replacement: Visibility(
              visible: !widget.mainController.isLoading && widget.mainController.criptoCurrencyTrendList.isEmpty,
              replacement: Center(
                child: CircularProgressIndicator(),
              ),
              child: Center(
                child: Text(
                  'No trending criptos found!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            child: ListView(
              scrollDirection: Axis.vertical,
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
                    children: [
                      SizedBox(
                        height: 300,
                        child: Observer(
                          builder: (_) => ListView(
                            children: widget.mainController.criptoCurrencyTrendList.map((e){
                              return Observer(
                                builder: (_) => PersonWidgets.criptoCard(
                                  cripto: e,
                                  onTap: () {},
                                ),
                              );
                            }).take(10).toList(),
                          ),
                        ),
                      )
                    ]
                  
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}