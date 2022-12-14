// Mocks generated by Mockito 5.3.2 from annotations
// in the_sss_store/test/screen/storages_menu/storages_menu_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:the_sss_store/repository/storages_menu_repository.dart' as _i3;
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart'
    as _i2;
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart'
    as _i4;

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

class _FakeStoragesMenuData_0 extends _i1.SmartFake
    implements _i2.StoragesMenuData {
  _FakeStoragesMenuData_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeStoragesMenuRepository_1 extends _i1.SmartFake
    implements _i3.StoragesMenuRepository {
  _FakeStoragesMenuRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [StoragesMenuViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockStoragesMenuViewModel extends _i1.Mock
    implements _i4.StoragesMenuViewModel {
  MockStoragesMenuViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set stateData(_i2.StoragesMenuData? value) => super.noSuchMethod(
        Invocation.setter(
          #stateData,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.StoragesMenuData get value => (super.noSuchMethod(
        Invocation.getter(#value),
        returnValue: _FakeStoragesMenuData_0(
          this,
          Invocation.getter(#value),
        ),
      ) as _i2.StoragesMenuData);
  @override
  _i3.StoragesMenuRepository getStoragesMenuRepository() => (super.noSuchMethod(
        Invocation.method(
          #getStoragesMenuRepository,
          [],
        ),
        returnValue: _FakeStoragesMenuRepository_1(
          this,
          Invocation.method(
            #getStoragesMenuRepository,
            [],
          ),
        ),
      ) as _i3.StoragesMenuRepository);
  @override
  _i5.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void showCreateStoragePopup() => super.noSuchMethod(
        Invocation.method(
          #showCreateStoragePopup,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void showRemoveStoragePopup() => super.noSuchMethod(
        Invocation.method(
          #showRemoveStoragePopup,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void hidePopup() => super.noSuchMethod(
        Invocation.method(
          #hidePopup,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<bool> createStorage(String? name) => (super.noSuchMethod(
        Invocation.method(
          #createStorage,
          [name],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<bool> removeStorage(String? name) => (super.noSuchMethod(
        Invocation.method(
          #removeStorage,
          [name],
        ),
        returnValue: _i5.Future<bool>.value(false),
      ) as _i5.Future<bool>);
  @override
  _i5.Future<String> getStorageDocumentID(String? name) => (super.noSuchMethod(
        Invocation.method(
          #getStorageDocumentID,
          [name],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
}
