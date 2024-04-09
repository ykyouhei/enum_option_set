import 'package:enum_option_set/enum_option_set.dart';

enum Topping {
  nuts,
  whippedCream,
  chocolateSauce,
}

void main() {
  final topping = EnumOptionSet<Topping>([]);
  print(topping.isEmpty); // true

  topping.add(Topping.nuts); // [nuts]
  print(topping);
  print(topping.isNotEmpty); // true
  print(topping.contains(Topping.nuts)); // true
  print(topping.contains(Topping.whippedCream)); // false

  topping.addAll([
    Topping.whippedCream,
    Topping.chocolateSauce
  ]); // [nuts, whippedCream, chocolateSauce]
  print(topping);

  print(topping.containsAll([
    Topping.nuts,
    Topping.whippedCream,
    Topping.chocolateSauce,
  ])); // true

  topping.remove(Topping.nuts); // [whippedCream, chocolateSauce]
  print(topping.contains(Topping.nuts)); // false
  print(topping);
}
