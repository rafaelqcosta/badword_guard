import 'package:badword_guard/badword_guard.dart';
import 'package:test/test.dart';

import 'custom_bad_words.dart';

void main() {
  void sharedTests(String description, LanguageChecker Function() createChecker) {
    group(description, () {
      late LanguageChecker checker;

      setUp(() {
        checker = createChecker();
      });

      test('containsBadLanguage returns true for input with bad language', () {
        final input = checker.containsBadLanguage('This message contains a bad word: shit');
        expect(input, isTrue);
      });

      test('containsBadLanguage returns false for input without bad language', () {
        final input = checker.containsBadLanguage('This message is clean');
        expect(input, isFalse);
      });

      test('filterBadWords replaces bad words with asterisks', () {
        final input = checker.filterBadWords('This message contains a bad word: shit');
        expect(input, equals('This message contains a bad word: ****'));
      });

      test('filterBadWords does not modify input without bad words', () {
        final input = checker.filterBadWords('This message is clean');
        expect(input, equals('This message is clean'));
      });
    });
  }

  sharedTests(
    'LanguageChecker (default configuration)',
    () => LanguageChecker(),
  );

  sharedTests(
    'LanguageChecker with custom bad words',
    () => LanguageChecker(additionalWords: customBadWords),
  );
}
