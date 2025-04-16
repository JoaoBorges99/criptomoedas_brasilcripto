import 'package:mobx/mobx.dart';
part 'cripto_model.g.dart';

class CriptoCurrency = CriptoCurrencyBase with _$CriptoCurrency;

abstract class CriptoCurrencyBase with Store {
  String id = '';
  String rank = '';
  String symbol = '';
  String name = '';
  String supply = '';
  String maxSupply = '';
  String marketCapUsd = '';
  String volumeUsd24Hr = '';
  String price = '';
  String changePercent24Hr = '';
  String vwap24Hr = '';

  @observable
  bool favorito = false;

  CriptoCurrencyBase({
    this.id = '',
    this.rank = '',
    this.symbol = '',
    this.name = '',
    this.supply = '',
    this.maxSupply = '',
    this.marketCapUsd = '',
    this.volumeUsd24Hr = '',
    this.price = '',
    this.changePercent24Hr = '',
    this.vwap24Hr = '',
    this.favorito = false
  });

  @action
  void adicionarRemoverFavorito(){
    favorito = !favorito;
  }

  CriptoCurrencyBase.fromJson(Map<String,dynamic> json) {
    id =  json['id'];
    rank =  json['rank'];
    symbol =  json['symbol'];
    name =  json['name'];
    supply =  json['supply'];
    maxSupply =  json['maxSupply'];
    marketCapUsd =  json['marketCapUsd'];
    volumeUsd24Hr =  json['volumeUsd24Hr'];
    price =  json['priceUsd'];
    changePercent24Hr =  json['changePercent24Hr'];
    vwap24Hr =  json['vwap24Hr'];
    favorito = json['favorito'] ?? false;
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'rank' : rank,
      'symbol' : symbol,
      'name' : name,
      'supply' : supply,
      'maxSupply' : maxSupply,
      'marketCapUsd' : marketCapUsd,
      'volumeUsd24Hr' : volumeUsd24Hr,
      'price' : price,
      'changePercent24Hr' : changePercent24Hr,
      'vwap24Hr' : vwap24Hr,
      'favorito' : favorito
    };
  }

}