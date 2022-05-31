import 'package:flutter_test/flutter_test.dart';
import 'package:ip_movie_recomandation/screens/CreateAccountScreen/register.dart';
void main() {
   test('Empty Email Test', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter Email!');
  });
test('Invalid Email Test', () {
  var result = FieldValidator.validateEmail('ajay');
  expect(result, 'Enter Valid Email!');
});
  test('Valid Email Test', () {
    var result = FieldValidator.validateEmail('ajay.kumar@nonstopio.com');
    expect(result, null);
  });
  test('Empty Password Test', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password');
  });

  test('Invalid Password Test', () {
    var result = FieldValidator.validatePassword('123');
    expect(result, 'Password must be longer than 6 char');
  });

  test('Valid Password Test', () {
    var result = FieldValidator.validatePassword('ajay12345');
    expect(result, null);
  });

   test('Empty Date Test', () {
    var result = FieldValidator.validateData('');
    expect(result, 'Enter Date!');
  });
   test('Invalid Date Test', () {
    var result = FieldValidator.validateData('1222.12.12');
    expect(result, 'Enter a valid date');
  });
    test('Valid Date Test', () {
    var result = FieldValidator.validateData('2001.12.12');
    expect(result, null);
  });
     test('Empty Genre Test', () {
    var result = FieldValidator.validateGenre('');
    expect(result, 'Enter a genre');
  });
   test('Invalid Genre Test', () {
    var result = FieldValidator.validateGenre('D');
    expect(result, 'Enter a valid genre');
  });
    test('Valid Genre Test', () {
    var result = FieldValidator.validateGenre('M');
    expect(result, null);
  });
  
     test('Empty Country Test', () {
    var result = FieldValidator.validateCountry('');
    expect(result, 'Enter a country');
  });
   test('Invalid Country Test', () {
    var result = FieldValidator.validateCountry('231ds@a');
    expect(result, 'Invalid Country');
  });
    test('Valid Country Test', () {
    var result = FieldValidator.validateCountry('Romania');
    expect(result, null);
  });
     test('Empty phone number Test', () {
    var result = FieldValidator.validatePhone('');
    expect(result, 'Enter a phone number');
  });
   test('Invalid phone number Test', () {
    var result = FieldValidator.validatePhone('231ds@a');
    expect(result, 'Invalid phone number');
  });
    test('Valid phone number Test', () {
    var result = FieldValidator.validatePhone('0785650301');
    expect(result, null);
  });
}