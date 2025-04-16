import 'package:criptomoedas_brasilcripto/global/widgets_personalizados.dart';
import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchPage extends StatefulWidget {
  final MainStore mainController;
  const SearchPage({super.key, required this.mainController});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  void initState() {
    super.initState();
    widget.mainController.valorPesquisado = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Observer(
          builder: (_) => Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        labelText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(),
                        ),
                      ),
                      onChanged: (value) {
                        widget.mainController.valorPesquisado = value;
                        if(widget.mainController.criptoPesquisada.isEmpty){
                          widget.mainController.searchNewCripto();
                        }
                      },
                      onFieldSubmitted: (value) {
                        widget.mainController.valorPesquisado = value;
                        widget.mainController.searchNewCripto();
                      },
                    ),
                  ),
                  Visibility(
                    visible: widget.mainController.criptoPesquisada.isNotEmpty,
                    replacement: Center(
                      child: Text(
                        'No criptos found!',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: widget.mainController.criptoPesquisada.take(100).length,
                        itemBuilder: (context, index) {
                          return Observer(
                            builder: (_) => PersonWidgets.criptoCard(
                              cripto: widget.mainController.criptoPesquisada[index],
                              onTap: () {},
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            
              Visibility(
                visible: widget.mainController.isLoadingSearch,
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}