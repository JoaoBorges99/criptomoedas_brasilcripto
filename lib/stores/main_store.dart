import 'package:criptomoedas_brasilcripto/global/settings.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:mobx/mobx.dart';
part 'main_store.g.dart';

class MainStore = MainStoreBase with _$MainStore;
abstract class MainStoreBase with Store {

  @observable
  String valorPesquisado = '';

  @observable
  ObservableList<CriptoCurrency> criptoCurrencyTrendList = ObservableList<CriptoCurrency>.of([
    CriptoCurrency(id: '1', name: 'Bitcoin', symbol: 'BTC', price: '50000', favorito: true),
    CriptoCurrency(id: '2', name: 'Ethereum', symbol: 'ETH', price: '4000'),
    CriptoCurrency(id: '3', name: 'Ripple', symbol: 'XRP', price: '1'),
    CriptoCurrency(id: '4', name: 'Litecoin', symbol: 'LTC', price: '200'),
  ]);

  @observable
  ObservableList<CriptoCurrency> criptoCurrencySearchList = ObservableList<CriptoCurrency>.of([]);

  @computed
  ObservableList<CriptoCurrency> get favListItens => criptoCurrencyTrendList.where((element) => element.favorito == true).toList().asObservable();

  @computed
  ObservableList<CriptoCurrency> get criptoPesquisada => criptoCurrencySearchList.where(
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
    newList.clear();
    
    List dados = await Settings.getRequest(editUrl: '&limit=13');
    newList.addAll(dados.map((e)=> CriptoCurrency.fromJson(e)).toList().asObservable());

    validarItensFavoritos(list: newList);

  }

  void limparItensFav(){
    for (CriptoCurrency item in favListItens){
      item.favorito = false;
    }
  }

}