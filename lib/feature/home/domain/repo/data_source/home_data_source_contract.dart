import 'package:cartzy_app/core/network/network.dart';
import 'package:cartzy_app/feature/home/domain/entities/category_entities.dart';
import 'package:cartzy_app/feature/home/domain/entities/product_entities.dart';

abstract class HomeDataSourceContract {
  Future<NetworkResult<List<CategoryEntities>>> getCategory();
  Future<NetworkResult<List<ProductEntities>>> getProduct();
}
