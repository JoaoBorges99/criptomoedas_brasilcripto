import 'package:criptomoedas_brasilcripto/global/settings.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_details.dart';
import 'package:criptomoedas_brasilcripto/models/cripto_model.dart';
import 'package:mobx/mobx.dart';
part 'details_store.g.dart';

class DetailStore = DetailStoreBase with _$DetailStore;
abstract class DetailStoreBase with Store{

  @observable
  bool isLoading = false;

  @observable
  List<CriptoDetails> criptoPriceList = [];

  Future<void> getCriptoPrice ({required CriptoCurrency cripto}) async {
    try{
      isLoading = true;

      List dados = await Settings.getRequest(editUrl: '${Settings.urlApi}/${cripto.id}/history${Settings.apiKey}&interval=m30', novaUrl: true);
      criptoPriceList.addAll(dados.map((e) => CriptoDetails.fromJson(e)).toList());

    }catch(e){
      criptoPriceList = [];
    }finally{
      isLoading = false;
    }
  }

}