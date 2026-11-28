import 'package:flutter_test/flutter_test.dart';
import 'package:underground_scan_ai/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('rejects empty', () {
      expect(Validators.email(''), ValidationError.required);
      expect(Validators.email('   '), ValidationError.required);
      expect(Validators.email(null), ValidationError.required);
    });
    test('rejects malformed', () {
      for (final v in ['abc', 'a@', '@b.com', 'a@b', 'a b@c.com']) {
        expect(Validators.email(v), ValidationError.invalidEmail, reason: v);
      }
    });
    test('accepts valid', () {
      for (final v in ['a@b.co', 'first.last+tag@sub.example.org', ' hse@demo.local ']) {
        expect(Validators.email(v), isNull, reason: v);
      }
    });
  });

  group('Validators.password', () {
    test('required and min length', () {
      expect(Validators.password(''), ValidationError.required);
      expect(Validators.password('1234567'), ValidationError.tooShort);
      expect(Validators.password('12345678'), isNull);
    });
  });
}
