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
  ObservableList<CriptoCurrency> criptoCurrencySearchList = ObservableList<CriptoCurrency>();

  @computed
  ObservableList<CriptoCurrency> get favItens {
    return criptoCurrencyTrendList.where((element) => element.favorito == true).toList().asObservable();
  }

  @computed
  ObservableList<CriptoCurrency> get criptoPesquisada => criptoCurrencySearchList.where(
    (item){
      return item.name.toLowerCase().contains(valorPesquisado.toLowerCase()) || item.symbol.toLowerCase().contains(valorPesquisado.toLowerCase()) ||item.id.toLowerCase().contains(valorPesquisado.toLowerCase());
    }
  ).toList().asObservable();

  bool validarFavorito ({required String id}) => favItens.any((iten) => iten.id == id);


}