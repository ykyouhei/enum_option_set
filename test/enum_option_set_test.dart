import 'package:test/test.dart';
import 'package:enum_option_set/enum_option_set.dart';

enum Fruit { apple, banana, orange }

void main() {
  group('EnumOptionSet', () {
    test('should create an EnumOptionSet from raw value', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.contains(Fruit.apple), isTrue);
      expect(options.contains(Fruit.banana), isFalse);
      expect(options.contains(Fruit.orange), isTrue);
    });

    test('should create an EnumOptionSet with specified options', () {
      final options = EnumOptionSet<Fruit>([Fruit.apple, Fruit.orange]);
      expect(options.contains(Fruit.apple), isTrue);
      expect(options.contains(Fruit.banana), isFalse);
      expect(options.contains(Fruit.orange), isTrue);
    });

    test('should add an option to the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(0);
      expect(options.add(Fruit.apple), isTrue);
      expect(options.contains(Fruit.apple), isTrue);
    });

    test(
        'should not add an option that is already present in the EnumOptionSet',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(1);
      expect(options.add(Fruit.apple), isFalse);
      expect(options.contains(Fruit.apple), isTrue);
    });

    test('should add all options in the collection to the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(0);
      options.addAll([Fruit.apple, Fruit.banana]);
      expect(options.contains(Fruit.apple), isTrue);
      expect(options.contains(Fruit.banana), isTrue);
    });

    test('should clear all options from the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      options.clear();
      expect(options.isEmpty, isTrue);
    });

    test('should check if the EnumOptionSet contains the specified option', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.contains(Fruit.apple), isTrue);
      expect(options.contains(Fruit.banana), isFalse);
    });

    test(
        'should check if the EnumOptionSet contains all options in the collection',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.containsAll([Fruit.apple, Fruit.orange]), isTrue);
      expect(options.containsAll([Fruit.apple, Fruit.banana]), isFalse);
    });

    test(
        'should return a new EnumOptionSet with options that are present in the current EnumOptionSet but not in the specified collection',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      final difference = options.difference([Fruit.apple]);
      expect(difference.contains(Fruit.apple), isFalse);
      expect(difference.contains(Fruit.orange), isTrue);
    });

    test(
        'should return a new EnumOptionSet with options that are present in both the current EnumOptionSet and the specified collection',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      final intersection = options.intersection([Fruit.apple, Fruit.banana]);
      expect(intersection.contains(Fruit.apple), isTrue);
      expect(intersection.contains(Fruit.banana), isFalse);
    });

    test('should remove the specified option from the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.remove(Fruit.apple), isTrue);
      expect(options.contains(Fruit.apple), isFalse);
    });

    test('should not remove an option that is not present in the EnumOptionSet',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.remove(Fruit.banana), isFalse);
      expect(options.contains(Fruit.banana), isFalse);
    });

    test('should remove all options in the collection from the EnumOptionSet',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      options.removeAll([Fruit.apple, Fruit.orange]);
      expect(options.contains(Fruit.apple), isFalse);
      expect(options.contains(Fruit.orange), isFalse);
    });

    test(
        'should retain only the options that are present in both the current EnumOptionSet and the specified collection',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      options.retainAll([Fruit.apple, Fruit.banana]);
      expect(options.contains(Fruit.apple), isTrue);
      expect(options.contains(Fruit.banana), isFalse);
      expect(options.contains(Fruit.orange), isFalse);
    });

    test(
        'should return a new EnumOptionSet that contains all the options from the current EnumOptionSet and the specified collection',
        () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      final union = options.union([Fruit.banana]);
      expect(union.contains(Fruit.apple), isTrue);
      expect(union.contains(Fruit.banana), isTrue);
      expect(union.contains(Fruit.orange), isTrue);
    });

    test('should check equality between EnumOptionSet instances', () {
      final options1 = EnumOptionSet<Fruit>.fromRawValue(5);
      final options2 = EnumOptionSet<Fruit>.fromRawValue(5);
      final options3 = EnumOptionSet<Fruit>.fromRawValue(3);
      expect(options1 == options2, isTrue);
      expect(options1 == options3, isFalse);
    });

    test('should calculate the hash code of the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.hashCode, isNotNull);
    });

    test('should return a string representation of the EnumOptionSet', () {
      final options = EnumOptionSet<Fruit>.fromRawValue(5);
      expect(options.toString(), 'EnumOptionSet<Fruit> [00000101]');
    });
  });
}
