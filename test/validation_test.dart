import 'package:forestryapp/util/validation.dart';
import 'package:test/test.dart';

/// Class used to test the Validation class, which provides Form widget validation errors.
void main() {
    group('isNotEmpty', () {
        test('isNotEmpty detects empty input', () {
            String? input = '';
            expect(Validation.isNotEmpty(input), 'Please enter a response.');
        });

        test('isNotEmpty detects null input', () {
            String? input;
            expect(Validation.isNotEmpty(input), 'Please enter a response.');
        });

        test('isNotEmpty ignores valid input', () {
            String? input = "Bob Anderson";
            expect(Validation.isNotEmpty(input), null);
        });
    });

    group('isValidPercentage', () {
        test('isValidPercentage ignores empty input', () {
            String? input = '';
            expect(Validation.isValidPercentage(input), null);
        });

        test('isValidPercentage ignores null input', () {
            String? input;
            expect(Validation.isValidPercentage(input), null);
        });

        test('isValidPercentage ignores valid high input', () {
            String? input = '100';
            expect(Validation.isValidPercentage(input), null);
        });

        test('isValidPercentage ignores valid low input', () {
            String? input = '0';
            expect(Validation.isValidPercentage(input), null);
        });

        test('isValidPercentage detects input above range', () {
            String? input = '101';
            expect(Validation.isValidPercentage(input), 'Please enter a valid percentage.');
        });

        test('isValidPercentage detects input below range', () {
            String? input = '-1';
            expect(Validation.isValidPercentage(input), 'Please enter a valid percentage.');
        });

        test('isValidPercentage detects non-numeric input', () {
            String? input = 'Bob Anderson';
            expect(Validation.isValidPercentage(input), 'Please enter a valid percentage.');
        });
    });

    group('isValidElevation', () {
        test('isValidElevation ignores empty input', () {
            String? input = '';
            expect(Validation.isValidElevation(input), null);
        });

        test('isValidElevation ignores null input', () {
            String? input;
            expect(Validation.isValidElevation(input), null);
        });

        test('isValidElevation ignores valid high input', () {
            String? input = '50000';
            expect(Validation.isValidElevation(input), null);
        });

        test('isValidElevation ignores valid low input', () {
            String? input = '-5000';
            expect(Validation.isValidElevation(input), null);
        });

        test('isValidElevation detects input above range', () {
            String? input = '50001';
            expect(Validation.isValidElevation(input), 'Please enter an elevation from -5000 to 50000.');
        });

        test('isValidElevation detects input below range', () {
            String? input = '-5001';
            expect(Validation.isValidElevation(input), 'Please enter an elevation from -5000 to 50000.');
        });

        test('isValidElevation detects non-numeric input', () {
            String? input = 'Bob Anderson';
            expect(Validation.isValidElevation(input), 'Please enter an elevation from -5000 to 50000.');
        });
    });
}