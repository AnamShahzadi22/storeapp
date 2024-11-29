import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;

  SearchProductsEvent({required this.query});
}