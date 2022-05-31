import 'package:flutter_test/flutter_test.dart';
import 'package:ip_movie_recomandation/screens/CreateAccountScreen/register.dart';
void main() {
   test('Empty Email Test should return Enter Email!', () {
    var result = FieldValidator.validateEmail('');
    expect(result, 'Enter Email!');
  });
test('Invalid Email Test should return Enter Valid Email!', () {
  var result = FieldValidator.validateEmail('ajay');
  expect(result, 'Enter Valid Email!');
});
  test('Valid Email Test should return null', () {
    var result = FieldValidator.validateEmail('ajay.kumar@nonstopio.com');
    expect(result, null);
  });
  test('Empty Password Test should return Enter Password', () {
    var result = FieldValidator.validatePassword('');
    expect(result, 'Enter Password');
  });

  test('Invalid Password Test sould return Password must be longer than 6 char', () {
    var result = FieldValidator.validatePassword('123');
    expect(result, 'Password must be longer than 6 char');
  });

  test('Valid Password Test should return null', () {
    var result = FieldValidator.validatePassword('ajay12345');
    expect(result, null);
  });

   test('Empty Date Test should return Enter Date', () {
    var result = FieldValidator.validateData('');
    expect(result, 'Enter Date!');
  });
   test('Invalid Date Test should return Enter a valid date', () {
    var result = FieldValidator.validateData('1222.12.12');
    expect(result, 'Enter a valid date');
  });
    test('Valid Date Test should return null', () {
    var result = FieldValidator.validateData('2001.12.12');
    expect(result, null);
  });
     test('Empty Genre Test should return Enter a genre', () {
    var result = FieldValidator.validateGenre('');
    expect(result, 'Enter a genre');
  });
   test('Invalid Genre Test should return Enter a valid genre', () {
    var result = FieldValidator.validateGenre('D');
    expect(result, 'Enter a valid genre');
  });
    test('Valid Genre Test', () {
    var result = FieldValidator.validateGenre('M');
    expect(result, null);
  });
  
     test('Empty Country Test should return Enter a country', () {
    var result = FieldValidator.validateCountry('');
    expect(result, 'Enter a country');
  });
   test('Invalid Country Test should return Invalid Country', () {
    var result = FieldValidator.validateCountry('231ds@a');
    expect(result, 'Invalid Country');
  });
    test('Valid Country Test should return null', () {
    var result = FieldValidator.validateCountry('Romania');
    expect(result, null);
  });
     test('Empty phone number Test should return Enter a phone number', () {
    var result = FieldValidator.validatePhone('');
    expect(result, 'Enter a phone number');
  });
   test('Invalid phone number Test should return Invalid phone number', () {
    var result = FieldValidator.validatePhone('231ds@a');
    expect(result, 'Invalid phone number');
  });
    test('Valid phone number Test should return null', () {
    var result = FieldValidator.validatePhone('0785650301');
    expect(result, null);
  });
}