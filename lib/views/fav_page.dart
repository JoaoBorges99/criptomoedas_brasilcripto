import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:criptomoedas_brasilcripto/views/cripto_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesPage extends StatefulWidget {
  final MainStore mainController;

  const FavoritesPage({super.key, required this.mainController});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: PopupMenuButton(
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.star, size: 15,),
                    SizedBox(width: 8),
                    Text('Limpar favoritos'),
                  ],
                ),
                onTap: (){
                  showDialog(
                    context: context, 
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Limpar favoritos'),
                        content: Text('Deseja realmente limpar todos os favoritos?'),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              widget.mainController.limparItensFav();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Lista de favoritos limpa!',
                                    style: TextStyle(
                                      color:Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ) ,
                                ),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(Colors.red)
                            ),
                            child: Text('Limpar',style: TextStyle(color:Colors.white),),
                          ),  
                        ],
                      );
                    },
                  );
                },
              ),
            ];
          },
        ),
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
        child: Observer(
          builder: (_) => Visibility(
            visible: widget.mainController.favListItens.isNotEmpty,
            replacement: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star_border,
                    color: Colors.grey[400],
                    size: 40,
                  ),
                  Text(
                    'Nenhuma favorita ainda',
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 18
                    ),
                  ),
                  Text(
                    'Adicione suas cryptos favoritas',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 15
                    ),
                  )
                ],
              ),
            ),
            child: ListView.builder(
              itemCount: widget.mainController.favListItens.length,
              itemBuilder: (context, index) {
                return PersonWidgets.criptoCard(
                  cripto: widget.mainController.favListItens[index],
                  adicionarRemoverFavorito: widget.mainController.salvarFavoritos,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CriptoDetailsPage(cripto: widget.mainController.favListItens[index],),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}