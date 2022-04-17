import 'package:padel/src/services_models/models.dart';
import 'package:padel/src/services_models/services.dart';

class ListStadiumsMax {
  static List<StadiumMax> list = [];
  static bool isNull = true;
  static bool isLoading = false;
  static late String selectedType;

  static bool get isEmpty => list.isEmpty;

  static bool get isNotEmpty => list.isNotEmpty;

  static bool get isNotNull => !isNull;

  static int get length => list.length;

  static Future<void> getList(String type) async {
    selectedType = type;
    if (isNotNull || isLoading) return;
    isLoading = true;
    list = await ApiCalls.getListStadiums(type);
    isNull = false;
    isLoading = false;
  }

  static Future<void> refresh() async {
    isNull = true;
    await getList(selectedType);
  }

  static void reset() {
    isNull = true;
    isLoading = false;
    list.clear();
  }
}
