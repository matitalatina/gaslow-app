import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('it should parse set of numbers', () {
    expect(Set.of(jsonDecode('[1,2,2,3]')), Set.of([1, 2, 3]));
  });

  test('it should serialize to JSON', () {
    expect(jsonEncode(Set.of([1, 2, 3]).toList()), '[1,2,3]');
  });
  test('it should deserialize empty list JSON', () {
    expect(Set.from(jsonDecode('[]')), Set.identity());
  });
}