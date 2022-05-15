import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class ListStadiums {
  static List<Game> listGames = [];
  static List<Stadium> list = [];
  static bool isNull = true;
  static bool isLoading = false;
  static late String selectedType;

  static bool get isEmpty => list.isEmpty;

  static bool get isNotEmpty => list.isNotEmpty;

  static bool get isNotNull => !isNull;

  static int get length => list.length;

  static Future<void> getListGames(bool refresh) async {
    // if (isNotNull || isLoading) return;
    // isLoading = true;
    if (isNull || refresh) {
      listGames = await ApiCalls.getListGames();
    }
    // isNull = false;
    // isLoading = false;
  }

  static Future<void> getList(String type, {bool refresh = false}) async {
    if (isNotNull) return;
    isLoading = true;
    await getListGames(refresh);
    filterListGames(type);
    isNull = false;
    isLoading = false;
  }

  static void filterListGames(String type) {
    selectedType = type;
    list.clear();
    Iterable<Game> filterType = listGames.where((element) =>
        selectedType == 'ALL' ? true : element.type == selectedType);
    for (var game in filterType) {
      for (var ground in game.grounds) {
        for (var stadium in ground.stadiums) {
          list.add(stadium);
        }
      }
    }
  }

  static Future<void> refresh() async {
    isNull = true;
    await getList(selectedType, refresh: true);
  }

  static void reset([bool resetGames = true]) {
    isNull = true;
    isLoading = false;
    list.clear();
    if (resetGames) {
      listGames.clear();
    }
  }
}
