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
  // var _totalPrice = 0;

  //  get totalPrice => _totalPrice;
  //  CalculatePrices(
  //   var newbuffalo_milk_price ,
  //   var newcow_milk_price ,
  //   var newmix_milk_price ,
  //   var newyogurt_price ,
  //   var newbutter_price ,
  //   var newdesi_ghee_price ,
  //   var delivery_charges
  //  ) {
  //  _totalPrice = 
  //        newbuffalo_milk_price +
  //        newcow_milk_price +
  //        newmix_milk_price +
  //        newyogurt_price +
  //        newbutter_price +
  //        newdesi_ghee_price +
  //        delivery_charges;
  //   notifyListeners();
  // }

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
  void reset(String productType) {
    _counts[productType] = 0;
    notifyListeners();
  }
}
