import 'dart:convert';

class ApiResponse {
  int? total;
  int? totalHits;
  List<dynamic>? hits;

  ApiResponse(this.total, this.totalHits, this.hits);

  static dynamic fromJson(dynamic json) {
    // print('json: $json');

    int total = json['total'] as int;
    //json[0]['total'] as int;
    int totalHits = json['totalHits'] as int;
    // print('Total images: $total');
    // print('Total images: $totalHits');

    List<dynamic>? hits;
    if (json['hits'] != null) {
      hits = json['hits']; //<Hits>[];
      // json['hits'].forEach((v) {
      //   hits!.add(Hits.fromJson(v));
      // });
    }
    return ApiResponse(total, totalHits, hits);
  }
}
