// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_app_bar_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BottomAppBarState on _BottomAppBarStateBase, Store {
  Computed<Map<BottomAppBarItem, Widget>>? _$_itemToPageComputed;

  @override
  Map<BottomAppBarItem, Widget> get _itemToPage => (_$_itemToPageComputed ??=
          Computed<Map<BottomAppBarItem, Widget>>(() => super._itemToPage,
              name: '_BottomAppBarStateBase._itemToPage'))
      .value;
  Computed<List<BottomAppBarItem>>? _$itemsComputed;

  @override
  List<BottomAppBarItem> get items =>
      (_$itemsComputed ??= Computed<List<BottomAppBarItem>>(() => super.items,
              name: '_BottomAppBarStateBase.items'))
          .value;
  Computed<List<Widget>>? _$pagesComputed;

  @override
  List<Widget> get pages =>
      (_$pagesComputed ??= Computed<List<Widget>>(() => super.pages,
              name: '_BottomAppBarStateBase.pages'))
          .value;

  late final _$currentIndexAtom =
      Atom(name: '_BottomAppBarStateBase.currentIndex', context: context);

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
items: ${items},
pages: ${pages}
    ''';
  }
}
