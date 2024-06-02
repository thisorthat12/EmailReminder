// Mocks generated by Mockito 5.4.4 from annotations
// in email_reminder/test/display_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:email_reminder/email_send_service.dart' as _i9;
import 'package:email_reminder/http_service.dart' as _i5;
import 'package:email_reminder/isar_service.dart' as _i4;
import 'package:email_reminder/model/item.dart' as _i7;
import 'package:email_reminder/model/settings.dart' as _i8;
import 'package:http/http.dart' as _i3;
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

class _FakeClient_1 extends _i1.SmartFake implements _i3.Client {
  _FakeClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResponse_2 extends _i1.SmartFake implements _i3.Response {
  _FakeResponse_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIsarService_3 extends _i1.SmartFake implements _i4.IsarService {
  _FakeIsarService_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeHttpService_4 extends _i1.SmartFake implements _i5.HttpService {
  _FakeHttpService_4(
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
class MockIsarService extends _i1.Mock implements _i4.IsarService {
  MockIsarService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Isar> get db => (super.noSuchMethod(
        Invocation.getter(#db),
        returnValue: _i6.Future<_i2.Isar>.value(_FakeIsar_0(
          this,
          Invocation.getter(#db),
        )),
      ) as _i6.Future<_i2.Isar>);

  @override
  set db(_i6.Future<_i2.Isar>? _db) => super.noSuchMethod(
        Invocation.setter(
          #db,
          _db,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<_i2.Isar> openDB() => (super.noSuchMethod(
        Invocation.method(
          #openDB,
          [],
        ),
        returnValue: _i6.Future<_i2.Isar>.value(_FakeIsar_0(
          this,
          Invocation.method(
            #openDB,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Isar>);

  @override
  _i6.Future<void> saveItem(_i7.Item? item) => (super.noSuchMethod(
        Invocation.method(
          #saveItem,
          [item],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<List<_i7.Item>> getAllItems() => (super.noSuchMethod(
        Invocation.method(
          #getAllItems,
          [],
        ),
        returnValue: _i6.Future<List<_i7.Item>>.value(<_i7.Item>[]),
      ) as _i6.Future<List<_i7.Item>>);

  @override
  _i6.Future<void> deleteItem(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteItem,
          [id],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<void> saveSettings(_i8.Settings? settings) => (super.noSuchMethod(
        Invocation.method(
          #saveSettings,
          [settings],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<List<_i8.Settings>> getSettings() => (super.noSuchMethod(
        Invocation.method(
          #getSettings,
          [],
        ),
        returnValue: _i6.Future<List<_i8.Settings>>.value(<_i8.Settings>[]),
      ) as _i6.Future<List<_i8.Settings>>);
}

/// A class which mocks [HttpService].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpService extends _i1.Mock implements _i5.HttpService {
  MockHttpService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_1(
          this,
          Invocation.getter(#client),
        ),
      ) as _i3.Client);

  @override
  _i6.Future<_i3.Response> postEmail(
    _i8.Settings? settings,
    String? body,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #postEmail,
          [
            settings,
            body,
          ],
        ),
        returnValue: _i6.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #postEmail,
            [
              settings,
              body,
            ],
          ),
        )),
      ) as _i6.Future<_i3.Response>);
}

/// A class which mocks [EmailSendService].
///
/// See the documentation for Mockito's code generation for more information.
class MockEmailSendService extends _i1.Mock implements _i9.EmailSendService {
  MockEmailSendService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.IsarService get isarService => (super.noSuchMethod(
        Invocation.getter(#isarService),
        returnValue: _FakeIsarService_3(
          this,
          Invocation.getter(#isarService),
        ),
      ) as _i4.IsarService);

  @override
  _i5.HttpService get httpService => (super.noSuchMethod(
        Invocation.getter(#httpService),
        returnValue: _FakeHttpService_4(
          this,
          Invocation.getter(#httpService),
        ),
      ) as _i5.HttpService);

  @override
  _i6.Future<_i3.Response> sendEmailAtExpiry(_i7.Item? item) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendEmailAtExpiry,
          [item],
        ),
        returnValue: _i6.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #sendEmailAtExpiry,
            [item],
          ),
        )),
      ) as _i6.Future<_i3.Response>);

  @override
  _i6.Future<_i3.Response> sendEmailWeekBefore(_i7.Item? item) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendEmailWeekBefore,
          [item],
        ),
        returnValue: _i6.Future<_i3.Response>.value(_FakeResponse_2(
          this,
          Invocation.method(
            #sendEmailWeekBefore,
            [item],
          ),
        )),
      ) as _i6.Future<_i3.Response>);
}