import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesPage extends StatefulWidget {
  final MainStore mainController;

  const FavoritesPage({super.key, required this.mainController});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
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
      body: Observer(
        builder: (_) => Visibility(
          visible: widget.mainController.favListItens.isNotEmpty,
          replacement: Center(
            child: Text(
              'Não há favoritos!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: widget.mainController.favListItens.length,
            itemBuilder: (context, index) {
              return PersonWidgets.criptoCard(
                cripto: widget.mainController.favListItens[index],
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}