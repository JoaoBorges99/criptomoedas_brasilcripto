// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cripto_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CriptoCurrency on CriptoCurrencyBase, Store {
  late final _$favoritoAtom =
      Atom(name: 'CriptoCurrencyBase.favorito', context: context);

  @override
  bool get favorito {
    _$favoritoAtom.reportRead();
    return super.favorito;
  }

  @override
  set favorito(bool value) {
    _$favoritoAtom.reportWrite(value, super.favorito, () {
      super.favorito = value;
    });
  }

  late final _$CriptoCurrencyBaseActionController =
      ActionController(name: 'CriptoCurrencyBase', context: context);

  @override
  void adicionarRemoverFavorito() {
    final _$actionInfo = _$CriptoCurrencyBaseActionController.startAction(
        name: 'CriptoCurrencyBase.adicionarRemoverFavorito');
    try {
      return super.adicionarRemoverFavorito();
    } finally {
      _$CriptoCurrencyBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favorito: ${favorito}
    ''';
  }
}
