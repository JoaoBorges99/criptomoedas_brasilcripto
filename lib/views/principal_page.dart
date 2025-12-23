import 'package:criptomoedas_brasilcripto/stores/main_store.dart';
import 'package:criptomoedas_brasilcripto/views/fav_page.dart';
import 'package:criptomoedas_brasilcripto/views/search_page.dart';
import 'package:criptomoedas_brasilcripto/views/trend_page.dart';
import 'package:flutter/material.dart';

class PrincipalPage extends StatefulWidget {
  const PrincipalPage({super.key});

  @override
  State<PrincipalPage> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> with TickerProviderStateMixin {
  
  int indexAtual = 0;
  TabController? _tabController;
  MainStore mainController = MainStore();

  @override
  void initState() {
    super.initState();
    mainController.getAllTrendCripto(newList: mainController.criptoCurrencyTrendList).then((value){
      mainController.recuperarFavoritos();
    });
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            TrendPage(mainController: mainController,),
            SearchPage(mainController: mainController,),
            FavoritesPage(mainController: mainController,),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 15, 23, 42),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: TabBar(
          splashBorderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.local_fire_department_outlined),
              child: Text('Em alta'),
            ),
            Tab(
              icon: Icon(Icons.search),
              child: Text('Pesquisar'),
            ),
            Tab(
              icon: Icon(Icons.star_border_purple500),
              child: Text('Favoritos'),
            ),
          ],
        ),
      ),
    );
  }

}