import 'package:ip_movie_recomandation/screens/LoginScreen/login.dart';
import 'package:test/test.dart';

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
}