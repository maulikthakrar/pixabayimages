import 'package:get/get_connect/http/src/response/response.dart';
import 'package:pixabay/apis/api_response.dart';
import 'package:pixabay/apis/master.dart';
import 'package:pixabay/models/pixabay_model.dart';

class ImagesProvider extends MasterConnect {
  final String apiKey = '46101346-961b76ecb63c469495d9ad373';

  Future<List<Hits>> getImages(String query) async {
    try {
      final Map<String, dynamic> queryParams = {
        'key': apiKey,
        'q': query,
        'image_type': 'photo',
      };
      Response response;
      response = await get('/api/', query: queryParams);
      print('Response body: ${response.body}');

      if (response.hasError) {
        throw Exception('API ERROR! ERROR CODE:${response.statusCode}');
      }
      if (response.body.hits != null && response.body.hits.isNotEmpty) {
        return (response.body as ApiResponse)
            .hits!
            .map((e) => Hits.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (err, st) {
      print(err);
      print(st);
      return [];
    }
  }
}
