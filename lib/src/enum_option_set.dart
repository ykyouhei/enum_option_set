/// Represents a set of options for a specific type of enumeration.
///
/// An [EnumOptionSet] is a collection of options that can be combined and manipulated using bitwise operations.
/// It provides methods for adding, removing, checking containment, and performing set operations such as union, intersection, and difference.
///
/// The generic type parameter `T` must be an enumeration type that extends the `Enum` class.
///
/// Example usage:
/// ```dart
/// enum Fruit { apple, banana, orange }
///
/// final options = EnumOptionSet<Fruit>.fromRawValue(5); // Represents a set with `apple` and `orange`
/// options.add(Fruit.banana); // Adds `banana` to the set
/// options.contains(Fruit.apple); // Returns true
/// options.remove(Fruit.orange); // Removes `orange` from the set
/// ```
final class EnumOptionSet<T extends Enum> {
  /// The raw integer value of the option set.
  int get rawValue => _rawValue;
  int _rawValue;

  /// Creates an [EnumOptionSet] instance from a raw integer value.
  ///
  /// The [rawValue] represents the bitwise combination of the options.
  /// Each option is represented by a unique bit flag.
  /// To create an [EnumOptionSet] with specific options, use the [EnumOptionSet] constructor instead.
  EnumOptionSet.fromRawValue(this._rawValue);

  /// Creates an [EnumOptionSet] instance with the specified options.
  ///
  /// The [options] parameter is an iterable collection of enumeration values.
  /// The resulting [EnumOptionSet] will contain all the options specified in the [options] collection.
  factory EnumOptionSet(Iterable<T> options) => EnumOptionSet.fromRawValue(
        options.fold(0, (acc, option) => acc | option.bitFlag),
      );

  /// Returns `true` if the option set is empty (contains no options).
  bool get isEmpty => _rawValue == 0;

  /// Returns `true` if the option set is not empty (contains at least one option).
  bool get isNotEmpty => _rawValue != 0;

  /// Adds the specified option to the option set.
  ///
  /// Returns `true` if the option was added successfully.
  /// Returns `false` if the option is already present in the option set.
  bool add(T option) {
    if (contains(option)) return false;
    _rawValue |= option.bitFlag;
    return true;
  }

  /// Adds all the options in the specified collection to the option set.
  void addAll(Iterable<T> options) => options.forEach(add);

  /// Removes all options from the option set.
  void clear() => _rawValue = 0;

  /// Returns `true` if the option set contains the specified option.
  bool contains(T option) => _rawValue & option.bitFlag != 0;

  /// Returns `true` if the option set contains all the options in the specified collection.
  bool containsAll(Iterable<T> options) =>
      options.every((option) => contains(option));

  /// Returns a new option set that contains the options that are present in the current option set but not in the specified collection.
  EnumOptionSet<T> difference(Iterable<T> options) =>
      EnumOptionSet.fromRawValue(rawValue & ~EnumOptionSet(options).rawValue);

  /// Returns a new option set that contains the options that are present in both the current option set and the specified collection.
  EnumOptionSet<T> intersection(Iterable<T> options) =>
      EnumOptionSet.fromRawValue(
        rawValue & EnumOptionSet(options).rawValue,
      );

  /// Removes the specified option from the option set.
  ///
  /// Returns `true` if the option was removed successfully.
  /// Returns `false` if the option is not present in the option set.
  bool remove(T option) {
    if (!contains(option)) return false;
    _rawValue &= ~option.bitFlag;
    return true;
  }

  /// Removes all the options in the specified collection from the option set.
  void removeAll(Iterable<T> options) => options.forEach(remove);

  /// Retains only the options that are present in both the current option set and the specified collection.
  void retainAll(Iterable<T> options) =>
      _rawValue = _rawValue & EnumOptionSet(options).rawValue;

  /// Returns a new option set that contains all the options from the current option set and the specified collection.
  EnumOptionSet<T> union(Iterable<T> options) =>
      EnumOptionSet.fromRawValue(rawValue | EnumOptionSet(options).rawValue);

  @override
  operator ==(Object other) =>
      other is EnumOptionSet<T> ? _rawValue == other._rawValue : false;

  @override
  int get hashCode => rawValue.hashCode;

  @override
  String toString() =>
      'EnumOptionSet<$T> [${_rawValue.toRadixString(2).padLeft(8, '0')}]';
}

extension _EnumFlag on Enum {
  /// Returns the value of the enum as a bit flag.
  ///
  /// The bit flag is a unique integer value that represents the enum value.
  /// It can be used to perform bitwise operations on option sets.
  int get bitFlag => 1 << index;
}
