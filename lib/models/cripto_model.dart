import 'package:mobx/mobx.dart';
part 'cripto_model.g.dart';

class CriptoCurrency = CriptoCurrencyBase with _$CriptoCurrency;

abstract class CriptoCurrencyBase with Store {
  late String id;
  late String name;
  late String symbol;
  late String price;

  @observable
  bool favorito = false;

  CriptoCurrencyBase({
    this.id = '',
    this.name = '',
    this.symbol = '',
    this.price = '',
    this.favorito = false
  });

  @action
  void adicionarRemoverFavorito(){
    favorito = !favorito;
  }

}