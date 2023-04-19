import 'package:flutter/foundation.dart';

// class MilkProvider with ChangeNotifier {
//   int _buffaloMilkCount = 0;
//   int _cowMilkCount = 0;

//   int get buffaloMilkCount => _buffaloMilkCount;
//   int get cowMilkCount => _cowMilkCount;

//   void incrementBuffaloMilkCount() {
//     _buffaloMilkCount++;
//     notifyListeners();
//   }

//   void decrementBuffaloMilkCount() {
//     _buffaloMilkCount--;
//     notifyListeners();
//   }

//   void incrementCowMilkCount() {
//     _cowMilkCount++;
//     notifyListeners();
//   }
//   void decrementCowMilkCount() {
//     _cowMilkCount--;
//     notifyListeners();
//   }
// }
class ShoppingItemProvider with ChangeNotifier {
  Map<String, int> _counts = {
    'Buffalo Milk': 0,
    'Cow Milk': 0,
    'Mix Milk': 0,
    'Yogurt': 0,
    'Butter': 0,
    'Desi Ghee': 0,
  };
  

  int getCount(String productType) {
    return _counts[productType] ?? 0;
  }

  void incrementCount(String productType) {
    _counts[productType] = getCount(productType) + 1;
    notifyListeners();
  }

  void decrementCount(String productType) {
    _counts[productType] =
        _counts[productType]! < 1 ? 0 : getCount(productType) - 1;
    notifyListeners();
  }
}
