import 'package:get/get.dart';
import 'package:pixabay/apis/api_response.dart';

class MasterConnect extends GetConnect {
  final String corsProxy = 'https://cors-anywhere.herokuapp.com/';

  @override
  void onInit() {
    httpClient.baseUrl = 'https://pixabay.com';
    httpClient.defaultDecoder = ApiResponse.fromJson;
    super.onInit();
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) {
    return super
        .get(url, contentType: contentType, query: query, decoder: decoder);
  }

  @override
  Future<Response<T>> post<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) {
    //print(url);
    return super.post(url, body,
        contentType: contentType,
        query: query,
        decoder: decoder,
        uploadProgress: uploadProgress);
  }
}
