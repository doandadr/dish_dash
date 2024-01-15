// To parse this JSON data, do
//
//     final addReviewResult = addReviewResultFromJson(jsonString);

import 'dart:convert';

AddReviewResult addReviewResultFromJson(String str) => AddReviewResult.fromJson(json.decode(str));

String addReviewResultToJson(AddReviewResult data) => json.encode(data.toJson());

class AddReviewResult {
  bool error;
  String message;
  List<CustomerReview> customerReviews;

  AddReviewResult({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  factory AddReviewResult.fromJson(Map<String, dynamic> json) => AddReviewResult(
    error: json["error"],
    message: json["message"],
    customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
  };
}

class CustomerReview {
  String name;
  String review;
  String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "review": review,
    "date": date,
  };
}
