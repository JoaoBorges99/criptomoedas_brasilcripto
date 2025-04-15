// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainStore on MainStoreBase, Store {
  Computed<ObservableList<CriptoCurrency>>? _$favItensComputed;

  @override
  ObservableList<CriptoCurrency> get favItens => (_$favItensComputed ??=
          Computed<ObservableList<CriptoCurrency>>(() => super.favItens,
              name: 'MainStoreBase.favItens'))
      .value;
  Computed<ObservableList<CriptoCurrency>>? _$criptoPesquisadaComputed;

  @override
  ObservableList<CriptoCurrency> get criptoPesquisada =>
      (_$criptoPesquisadaComputed ??= Computed<ObservableList<CriptoCurrency>>(
              () => super.criptoPesquisada,
              name: 'MainStoreBase.criptoPesquisada'))
          .value;

  late final _$valorPesquisadoAtom =
      Atom(name: 'MainStoreBase.valorPesquisado', context: context);

  @override
  String get valorPesquisado {
    _$valorPesquisadoAtom.reportRead();
    return super.valorPesquisado;
  }

  @override
  set valorPesquisado(String value) {
    _$valorPesquisadoAtom.reportWrite(value, super.valorPesquisado, () {
      super.valorPesquisado = value;
    });
  }

  late final _$criptoCurrencyTrendListAtom =
      Atom(name: 'MainStoreBase.criptoCurrencyTrendList', context: context);

  @override
  ObservableList<CriptoCurrency> get criptoCurrencyTrendList {
    _$criptoCurrencyTrendListAtom.reportRead();
    return super.criptoCurrencyTrendList;
  }

  @override
  set criptoCurrencyTrendList(ObservableList<CriptoCurrency> value) {
    _$criptoCurrencyTrendListAtom
        .reportWrite(value, super.criptoCurrencyTrendList, () {
      super.criptoCurrencyTrendList = value;
    });
  }

  late final _$criptoCurrencySearchListAtom =
      Atom(name: 'MainStoreBase.criptoCurrencySearchList', context: context);

  @override
  ObservableList<CriptoCurrency> get criptoCurrencySearchList {
    _$criptoCurrencySearchListAtom.reportRead();
    return super.criptoCurrencySearchList;
  }

  @override
  set criptoCurrencySearchList(ObservableList<CriptoCurrency> value) {
    _$criptoCurrencySearchListAtom
        .reportWrite(value, super.criptoCurrencySearchList, () {
      super.criptoCurrencySearchList = value;
    });
  }

  @override
  String toString() {
    return '''
valorPesquisado: ${valorPesquisado},
criptoCurrencyTrendList: ${criptoCurrencyTrendList},
criptoCurrencySearchList: ${criptoCurrencySearchList},
favItens: ${favItens},
criptoPesquisada: ${criptoPesquisada}
    ''';
  }
}
