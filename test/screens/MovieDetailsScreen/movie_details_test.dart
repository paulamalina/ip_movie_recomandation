import 'package:flutter_test/flutter_test.dart';
import 'package:ip_movie_recomandation/screens/MovieDetailsScreen/movie_details.dart';

void main() {
    test('Empty Comment Test', () {
    var result = FieldValidator.validateComment('');
    expect(result, 'Enter Comment!');
  });
    test('Valid Comment Test', () {
    var result = FieldValidator.validateComment('sajidasj');
    expect(result, null);
  });
}