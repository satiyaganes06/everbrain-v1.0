import 'dart:math';

class GeneratePassword {
  String generatePassword(
      {required  length, required bool uppercase,  required bool lowercase, required bool numbers, required bool symbols}) {
    final random = Random.secure();
    final letters = <String>[];
    if (uppercase) {
      letters.addAll(
          List.generate(26, (index) => String.fromCharCode(index + 65)));
    }
    if (lowercase) {
      letters.addAll(
          List.generate(26, (index) => String.fromCharCode(index + 97)));
    }
    if (numbers) {
      letters.addAll(List.generate(10, (index) => index.toString()));
    }
    if (symbols) {
      letters.addAll([
        '!',
        '@',
        '#',
        '\$',
        '%',
        '^',
        '&',
        '*',
        '(',
        ')',
        '-',
        '_',
        '+',
        '=',
        '[',
        ']',
        '{',
        '}',
        ';',
        ':',
        ',',
        '.',
        '<',
        '>',
        '/',
        '?',
        '|'
      ]);
    }
    final password =
        List.generate(length, (_) => letters[random.nextInt(letters.length)])
            .join();
    return password;
  }
}