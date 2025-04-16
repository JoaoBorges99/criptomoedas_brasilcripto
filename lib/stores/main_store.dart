import 'package:criptomoedas_brasilcripto/global/settings.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
part 'main_store.g.dart';

class MainStore = MainStoreBase with _$MainStore;
abstract class MainStoreBase with Store {

  @observable
  String valorPesquisado = '';

  @observable
  bool isLoading = false;

  @observable
  bool isLoadingSearch = false;

  @observable
  ObservableList<CriptoCurrency> criptoCurrencyTrendList = ObservableList<CriptoCurrency>.of([]);

  @computed
  ObservableList<CriptoCurrency> get favListItens {
    return criptoCurrencyTrendList.where((element) => element.favorito == true).toList().asObservable();
  }

  @computed
  ObservableList<CriptoCurrency> get criptoPesquisada => criptoCurrencyTrendList.where(
    (item)=> item.name.toLowerCase().contains(valorPesquisado.toLowerCase()) || item.symbol.toLowerCase().contains(valorPesquisado.toLowerCase()) ||item.id.toLowerCase().contains(valorPesquisado.toLowerCase())
  ).toList().asObservable();

  bool validarFavorito ({required String id}) => favListItens.any((iten) => iten.id == id);

  void validarItensFavoritos ({required ObservableList<CriptoCurrency> list}) {
    for( CriptoCurrency item in list){
      final bool isItemFav = favListItens.any((e) => e.id == item.id);
      if(isItemFav){
        item.favorito = true;
      }
    }

  }
  
  Future<void> getAllTrendCripto ({required ObservableList<CriptoCurrency> newList}) async {
    try{
      isLoading = true;

      List dados = await Settings.getRequest(editUrl: '&limit=50');
      newList.addAll(dados.map((e)=> CriptoCurrency.fromJson(e)).toList().asObservable());

      validarItensFavoritos(list: newList);
    }catch(e){
      newList.clear();
    }finally{
      isLoading = false;
    }

  }

  Future<void> searchNewCripto() async {
    try{
      isLoadingSearch = true;

      List dados = await Settings.getRequest(editUrl: '&search=$valorPesquisado');
      if (dados.isNotEmpty) {
        List<CriptoCurrency> novaLista = dados.map((e) => CriptoCurrency.fromJson(e)).toList();

        for(CriptoCurrency novoitem in novaLista){
          final bool isItemExist = criptoCurrencyTrendList.where((e) => e.id == novoitem.id).isEmpty;
          if(isItemExist){
            criptoCurrencyTrendList.add(novoitem);
          } 
        }
      }
    }catch(e){
      return;
    }finally{
      isLoadingSearch = false;
    }
  }
  
  void limparItensFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    for (CriptoCurrency item in favListItens){
      item.favorito = false;
    }
  }

  // Função para salvar a lista de favoritos
  Future<void> salvarFavoritos() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      // Converte a lista de favoritos em JSON
      List<String> favoritosJson = favListItens.map((item) => jsonEncode(item.toJson())).toList();

      await prefs.setStringList('favoritos', favoritosJson);
    } catch (e) {
      print('Erro ao salvar favoritos: $e');
    }
  }

  // Função para recuperar a lista de favoritos
  Future<void> recuperarFavoritos() async {
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? favoritosJson = prefs.getStringList('favoritos');

      if (favoritosJson != null) {
        List<CriptoCurrency> favoritos = favoritosJson.map((item) => CriptoCurrency.fromJson(jsonDecode(item))).toList();
        Set<CriptoCurrency> novasAdicoes = {};
        
        for (CriptoCurrency item in criptoCurrencyTrendList) {
          for(CriptoCurrency favitem in favoritos){
            if(favitem.id == item.id){
              item.favorito = true; 
            }else{
              novasAdicoes.add(favitem);
            }
          }
        }
        criptoCurrencyTrendList.addAll(novasAdicoes);
      }
    } catch (e) {
      print('Erro ao recuperar favoritos: $e');
    }
  }

}