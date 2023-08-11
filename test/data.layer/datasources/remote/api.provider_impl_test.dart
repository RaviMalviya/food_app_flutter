import 'package:food_app_flutter/core/error/exceptions.dart';
import 'package:food_app_flutter/core/util/helpers.dart';
import 'package:food_app_flutter/data.layer/data.sources/remote/api.provider_impl.dart';
import 'package:food_app_flutter/data.layer/dto/recipe.dto.dart';
import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixture_reader.dart';
import 'api.provider_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ApiProviderImpl apiProviderImpl;

  setUp(() {
    mockClient = MockClient();
    apiProviderImpl = ApiProviderImpl(client: mockClient);
  });

  // void setupMockHttpClientFailed404() {
  //   when(() => mockClient.get(any(), headers: any(named: 'headers')))
  //       .thenAnswer((_) =>
  //       Future.value(http.Response(fixture('trivia.json'), 404)));
  // }

  group('apiProviderImpl', () {
    test('''getRecipe, should perform a GET request on URL
            begin the end point with given header''', () async {
      //arrange
      var params = {"limit": "18", "start": "0", "tag": "list.recipe.popular"};
      var headers = {
        "x-rapidapi-key": "a5b80308amsh3abe18ed5b25b2c17090ajsn8c5c85b5b088",
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "useQueryString": "true",
      };
      final uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', params);

      when(mockClient.get(uri, headers: headers)).thenAnswer(
          (_) async => http.Response(fixture('get_recipe.json'), 200));
      //act
      final call = apiProviderImpl.getRecipe;
      //assert
      expect(await call(), isA<List<RecipeDto>>());
      safePrint("Okay Success!!!");
    });

    test('''getRecipe, should perform a GET request on URL
            begin the end point with given header''', () async {
      //arrange
      var params = {"limit": "18", "start": "0", "tag": "list.recipe.popular"};
      var headers = {
        "x-rapidapi-key": "a5b80308amsh3abe18ed5b25b2c17090ajsn8c5c85b5b088",
        "x-rapidapi-host": "yummly2.p.rapidapi.com",
        "useQueryString": "true",
      };
      final uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', params);
      when(mockClient.get(uri, headers: headers)).thenAnswer(
              (_) => Future.value(http.Response('Not Found', 404)));
      //act
      final call = apiProviderImpl.getRecipe;
      //assert
      expect(call(), throwsA(const TypeMatcher<ServerException>()));
      safePrint("Okay ServerException!!!");
    });

  });

}
