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
    // Retorna apenas os itens marcados como favoritos
    return criptoCurrencyTrendList.where((element) => element.favorito == true).toList().asObservable();
  }

  @computed
  ObservableList<CriptoCurrency> get criptoPesquisada {
    // Filtra a lista de criptomoedas com base no valor pesquisado
    return criptoCurrencyTrendList.where(
      (item) => item.name.toLowerCase().contains(valorPesquisado.toLowerCase()) || 
                item.symbol.toLowerCase().contains(valorPesquisado.toLowerCase()) || 
                item.id.toLowerCase().contains(valorPesquisado.toLowerCase())
    ).toList().asObservable();
  }

  // Verifica se uma criptomoeda está na lista de favoritos
  bool validarFavorito ({required String id}) => favListItens.any((iten) => iten.id == id);

  // Valida e atualiza o estado de favoritos na lista de criptomoedas
  void validarItensFavoritos ({required ObservableList<CriptoCurrency> list}) {
    for (CriptoCurrency item in list) {
      final bool isItemFav = favListItens.any((e) => e.id == item.id);
      if (isItemFav) {
        item.favorito = true;
      }
    }
  }
  
  // Função para buscar as criptomoedas em alta
  Future<void> getAllTrendCripto ({required ObservableList<CriptoCurrency> newList}) async {
    try {
      isLoading = true;

      // Faz uma requisição para obter as criptomoedas em alta
      List dados = await Settings.getRequest(editUrl: '&limit=50');
      
      // Converte os dados recebidos em objetos do tipo CriptoCurrency e adiciona à lista
      newList.addAll(dados.map((e) => CriptoCurrency.fromJson(e)).toList().asObservable());

      validarItensFavoritos(list: newList);
    } catch (e) {
      newList.clear();
    } finally {
      isLoading = false;
    }
  }

  // Função para buscar novas criptomoedas com base no valor pesquisado
  Future<void> searchNewCripto() async {
    try {
      isLoadingSearch = true;

      // Faz uma requisição para buscar criptomoedas pelo valor pesquisado
      List dados = await Settings.getRequest(editUrl: '&search=$valorPesquisado');
      if (dados.isNotEmpty) {
        List<CriptoCurrency> novaLista = dados.map((e) => CriptoCurrency.fromJson(e)).toList();

        // Adiciona apenas os itens que ainda não estão na lista
        for (CriptoCurrency novoitem in novaLista) {
          final bool isItemExist = criptoCurrencyTrendList.where((e) => e.id == novoitem.id).isEmpty;
          if (isItemExist) {
            criptoCurrencyTrendList.add(novoitem);
          } 
        }
      }
    } catch (e) {
      return;
    } finally {
      isLoadingSearch = false;
    }
  }
  
  // Limpa todos os itens marcados como favoritos
  void limparItensFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    for (CriptoCurrency item in favListItens) {
      item.favorito = false;
    }
  }

  // Salva a lista de favoritos no armazenamento local
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

  // Recupera a lista de favoritos do armazenamento local
  Future<void> recuperarFavoritos() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? favoritosJson = prefs.getStringList('favoritos');

      if (favoritosJson != null) {
        // Converte os dados salvos em objetos do tipo CriptoCurrency
        List<CriptoCurrency> favoritos = favoritosJson.map((item) => CriptoCurrency.fromJson(jsonDecode(item))).toList();
        Set<CriptoCurrency> novasAdicoes = {};
        
        // Atualiza o estado dos itens na lista principal
        for (CriptoCurrency item in criptoCurrencyTrendList) {
          for (CriptoCurrency favitem in favoritos) {
            if (favitem.id == item.id) {
              item.favorito = true; 
            } else {
              novasAdicoes.add(favitem);
            }
          }
        }

        // Adiciona novos favoritos que ainda não estão na lista principal
        criptoCurrencyTrendList.addAll(
          novasAdicoes.where((newAdd) => !criptoCurrencyTrendList.any((e) => e.id == newAdd.id)).toList()
        );
      }
    } catch (e) {
      print('Erro ao recuperar favoritos: $e');
    }
  }

}