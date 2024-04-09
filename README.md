EnumOptionSet is a Dart package that provides a way to manage a set of enum options. It allows you to add, remove, and check options in a set, and perform set operations like union, intersection, and difference.

## Features

- Create an EnumOptionSet from a list of enum options.
- Add and remove options from the set.
- Check if an option or a set of options is present in the set.
- Perform set operations: union, intersection, and difference.

## Getting started

To start using this package, add `enum_option_set` as a dependency in your `pubspec.yaml` file.

## Usage

Here is a short example of how to use the EnumOptionSet class:

```dart
import 'package:enum_option_set/enum_option_set.dart';

enum Topping {
  nuts,
  whippedCream,
  chocolateSauce,
}

void main() {
  final topping = EnumOptionSet<Topping>([]);
  topping.add(Topping.nuts);
  print(topping.contains(Topping.nuts)); // true
  topping.remove(Topping.nuts);
  print(topping.contains(Topping.nuts)); // false
}
