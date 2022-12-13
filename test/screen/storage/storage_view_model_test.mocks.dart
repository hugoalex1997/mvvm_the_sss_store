// Mocks generated by Mockito 5.3.2 from annotations
// in the_sss_store/test/screen/storage/storage_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:the_sss_store/model/item.dart' as _i3;
import 'package:the_sss_store/repository/storage_repository.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [StorageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageRepository extends _i1.Mock implements _i2.StorageRepository {
  MockStorageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.Item> getItemList() => (super.noSuchMethod(
        Invocation.method(
          #getItemList,
          [],
        ),
        returnValue: <_i3.Item>[],
      ) as List<_i3.Item>);
  @override
  _i4.Stream<List<_i3.Item>> observeItemList() => (super.noSuchMethod(
        Invocation.method(
          #observeItemList,
          [],
        ),
        returnValue: _i4.Stream<List<_i3.Item>>.empty(),
      ) as _i4.Stream<List<_i3.Item>>);
  @override
  _i4.Future<void> fetchItemList(String? documentID) => (super.noSuchMethod(
        Invocation.method(
          #fetchItemList,
          [documentID],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void addItem(
    String? documentID,
    String? name,
    int? stock,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #addItem,
          [
            documentID,
            name,
            stock,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeItem(
    String? documentID,
    String? name,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #removeItem,
          [
            documentID,
            name,
          ],
        ),
        returnValueForMissingStub: null,
      );
}