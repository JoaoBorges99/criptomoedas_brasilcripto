import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:criptomoedas_brasilcripto/views/cripto_details_page.dart';
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
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Recarregar',
          onPressed: () async {
            widget.mainController.getAllTrendCripto(newList: widget.mainController.criptoCurrencyTrendList);
          }, 
          icon: Icon(Icons.replay)
        ),
      ),
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
                  'Não há nenhuma cripto em alta no momento!',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            child: SingleChildScrollView(
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
                      child: Observer(
                        builder: (_) => PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: PageController(),
                          itemCount: widget.mainController.criptoCurrencyTrendList.sublist(10, 13).length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CriptoDetailsPage(cripto: widget.mainController.criptoCurrencyTrendList.sublist(10, 13)[index],),
                                  ),
                                );
                              },
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.primaries[index],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        child: Image.network(
                                          'https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${widget.mainController.criptoCurrencyTrendList.sublist(10, 13)[index].id.toLowerCase()}.png',
                                          errorBuilder: (context, error, stackTrace) {
                                            return Image.asset(
                                              'assets/cripto.png',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          width: 150,
                                          height: 150,
                                        ),
                                      ),
                                                    
                                      // Texto principal
                                      Positioned(
                                        left: 20,
                                        top: 40,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.mainController.criptoCurrencyTrendList.sublist(10, 13)[index].name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            Text(
                                              "Super Cripto",
                                              style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Maior preço",
                                              style: TextStyle(
                                                fontSize: 32,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.attach_money, color: Colors.yellow[600], size: 24),
                            const SizedBox(width: 8),
                            const Text(
                              'Top 10 Mais Valiosas',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 15,),
                    
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.mainController.criptoCurrencyTrendList.take(10).length,
                          itemBuilder: (context, index) {
                            CriptoCurrency topCriptos = widget.mainController.criptoCurrencyTrendList[index];
                                return PersonWidgets.criptoCard(
                                  cripto: topCriptos,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CriptoDetailsPage(cripto: topCriptos,),
                                      ),
                                    );                                    
                                  },
                                  adicionarRemoverFavorito:
                                      widget.mainController.salvarFavoritos,
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}