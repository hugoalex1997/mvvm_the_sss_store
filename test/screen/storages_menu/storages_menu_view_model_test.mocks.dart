// Mocks generated by Mockito 5.3.2 from annotations
// in the_sss_store/test/screen/storages_menu/storages_menu_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:mockito/mockito.dart' as _i1;
import 'package:the_sss_store/model/storage.dart' as _i2;
import 'package:the_sss_store/services/firebase/firebase_storages_menu_api.dart'
    as _i3;

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

class _FakeStorage_0 extends _i1.SmartFake implements _i2.Storage {
  _FakeStorage_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FirebaseStoragesMenuAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseStoragesMenuAPI extends _i1.Mock
    implements _i3.FirebaseStoragesMenuAPI {
  MockFirebaseStoragesMenuAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get storagesCollectionName => (super.noSuchMethod(
        Invocation.getter(#storagesCollectionName),
        returnValue: '',
      ) as String);
  @override
  _i4.Future<List<_i2.Storage>> getStoragesList() => (super.noSuchMethod(
        Invocation.method(
          #getStoragesList,
          [],
        ),
        returnValue: _i4.Future<List<_i2.Storage>>.value(<_i2.Storage>[]),
      ) as _i4.Future<List<_i2.Storage>>);
  @override
  _i4.Future<String?> getStorageDocumentID(String? name) => (super.noSuchMethod(
        Invocation.method(
          #getStorageDocumentID,
          [name],
        ),
        returnValue: _i4.Future<String?>.value(),
      ) as _i4.Future<String?>);
  @override
  _i2.Storage createStorage(String? storageName) => (super.noSuchMethod(
        Invocation.method(
          #createStorage,
          [storageName],
        ),
        returnValue: _FakeStorage_0(
          this,
          Invocation.method(
            #createStorage,
            [storageName],
          ),
        ),
      ) as _i2.Storage);
  @override
  _i4.Future<void> removeStorage(String? name) => (super.noSuchMethod(
        Invocation.method(
          #removeStorage,
          [name],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  _i4.Future<bool> storageFound(String? name) => (super.noSuchMethod(
        Invocation.method(
          #storageFound,
          [name],
        ),
        returnValue: _i4.Future<bool>.value(false),
      ) as _i4.Future<bool>);
}