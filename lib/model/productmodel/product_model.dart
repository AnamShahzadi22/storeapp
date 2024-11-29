import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String title,
    @Default('No description available') String description,
    String? category,
    required double price,
    @Default(0.0) double discountPercentage,
    @Default(0.0) double rating,
    @Default(0) int stock,
    @Default([]) List<String> tags,
    String? brand,
    String? sku,
    int? weight,
    Dimensions? dimensions,
    @Default('No warranty available') String warrantyInformation,
    String? shippingInformation,
    @Default('Unavailable') String availabilityStatus,
    @Default([]) List<Review> reviews,
    @Default('No return policy specified') String returnPolicy,
    @Default(1) int minimumOrderQuantity,
    Meta? meta,
    @Default([]) List<String> images,
    String? thumbnail,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}

@freezed
class Dimensions with _$Dimensions {
  const factory Dimensions({
    double? width,
    double? height,
    double? depth,
  }) = _Dimensions;

  factory Dimensions.fromJson(Map<String, dynamic> json) =>
      _$DimensionsFromJson(json);
}

@freezed
class Review with _$Review {
  const factory Review({
    @Default(0) int rating,
    @Default('No comment provided') String comment,
    DateTime? date,
    @Default('Anonymous') String reviewerName,
    String? reviewerEmail,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);
}

@freezed
class Meta with _$Meta {
  const factory Meta({
    @Default('N/A') String createdAt,
    @Default('N/A') String updatedAt,
    String? barcode,
    String? qrCode,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}

