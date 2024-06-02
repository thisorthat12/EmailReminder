// Mocks generated by Mockito 5.4.4 from annotations
// in email_reminder/test/settings_page_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:email_reminder/isar_service.dart' as _i3;
import 'package:email_reminder/model/item.dart' as _i5;
import 'package:email_reminder/model/settings.dart' as _i6;
import 'package:isar/isar.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIsar_0 extends _i1.SmartFake implements _i2.Isar {
  _FakeIsar_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [IsarService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIsarService extends _i1.Mock implements _i3.IsarService {
  MockIsarService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Isar> get db => (super.noSuchMethod(
        Invocation.getter(#db),
        returnValue: _i4.Future<_i2.Isar>.value(_FakeIsar_0(
          this,
          Invocation.getter(#db),
        )),
      ) as _i4.Future<_i2.Isar>);

  @override
  set db(_i4.Future<_i2.Isar>? _db) => super.noSuchMethod(
        Invocation.setter(
          #db,
          _db,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i4.Future<_i2.Isar> openDB() => (super.noSuchMethod(
        Invocation.method(
          #openDB,
          [],
        ),
        returnValue: _i4.Future<_i2.Isar>.value(_FakeIsar_0(
          this,
          Invocation.method(
            #openDB,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Isar>);

  @override
  _i4.Future<void> saveItem(_i5.Item? item) => (super.noSuchMethod(
        Invocation.method(
          #saveItem,
          [item],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i5.Item>> getAllItems() => (super.noSuchMethod(
        Invocation.method(
          #getAllItems,
          [],
        ),
        returnValue: _i4.Future<List<_i5.Item>>.value(<_i5.Item>[]),
      ) as _i4.Future<List<_i5.Item>>);

  @override
  _i4.Future<void> deleteItem(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteItem,
          [id],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<void> saveSettings(_i6.Settings? settings) => (super.noSuchMethod(
        Invocation.method(
          #saveSettings,
          [settings],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i4.Future<List<_i6.Settings>> getSettings() => (super.noSuchMethod(
        Invocation.method(
          #getSettings,
          [],
        ),
        returnValue: _i4.Future<List<_i6.Settings>>.value(<_i6.Settings>[]),
      ) as _i4.Future<List<_i6.Settings>>);
}
