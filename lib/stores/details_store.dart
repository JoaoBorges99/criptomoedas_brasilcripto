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

  // Função para buscar o histórico de preços de uma criptomoeda específica
  Future<void> getCriptoPrice ({required CriptoCurrency cripto}) async {
    try {
      isLoading = true;

      // Faz uma requisição para obter o histórico de preços da criptomoeda
      List dados = await Settings.getRequest(
        editUrl: '${Settings.urlApi}assets/${cripto.id}/history?interval=m30', 
        novaUrl: true
      );

      // Converte os dados recebidos em objetos do tipo CriptoDetails e adiciona à lista
      criptoPriceList.addAll(dados.map((e) => CriptoDetails.fromJson(e)).toList());

    } catch (e) {
      criptoPriceList = [];
    } finally {
      isLoading = false;
    }
  }

}