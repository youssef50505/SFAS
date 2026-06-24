import 'package:dio/dio.dart';
import '../../../core/constants/endpoints.dart';
import '../models/item.dart';

class ItemService {
  final Dio _dio;

  ItemService(this._dio);

  Future<List<Item>> getItems() async {
    try {
      final response = await _dio.get(Endpoints.items);
      final List<dynamic> data = response.data;
      return data.map((json) => Item.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<Item> createItem(Item item) async {
    try {
      final response = await _dio.post(
        Endpoints.items,
        data: item.toJson(),
      );
      return Item.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Item> updateItem(String id, Item item) async {
    try {
      final response = await _dio.put(
        Endpoints.itemDetails(id),
        data: item.toJson(),
      );
      return Item.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _dio.delete(Endpoints.itemDetails(id));
    } catch (e) {
      rethrow;
    }
  }
}
