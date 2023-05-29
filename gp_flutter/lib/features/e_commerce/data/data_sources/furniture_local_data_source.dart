import 'package:shared_preferences/shared_preferences.dart';

abstract class FurnitureLocalDataSource {
  Future<void> storeFavorite({required List<String> favoritesIds});

  List<String> getFavorite();
}

class FurnitureLocalDataSourceImpl extends FurnitureLocalDataSource {
  final SharedPreferences sharedPreferences;

  FurnitureLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  List<String> getFavorite() {
    return sharedPreferences.getStringList('favoritesIds') ?? [];
  }

  @override
  Future<void> storeFavorite({required List<String> favoritesIds}) async {
    await sharedPreferences.setStringList('favoritesIds', favoritesIds);
  }
}
