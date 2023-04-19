// import 'package:flutter/material.dart';
// import 'package:milk_zilla/provider/selected_item_provider.dart';
// import 'package:provider/provider.dart';



// class Help extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Milk Counter'),
//       ),
//       body: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     MilkButton(
//       productType: 'Buffalo Milk',
//       onPressed: () {
//         Provider.of<MilkProvider>(context, listen: false)
//             .incrementCount('Buffalo Milk');
//       },
//     ),
//     MilkButton(
//       productType: 'Cow Milk',
//       onPressed: () {
//         Provider.of<MilkProvider>(context, listen: false)
//             .incrementCount('Cow Milk');
//       },
//     ),
//     MilkButton(
//       productType: 'Yogurt',
//       onPressed: () {
//         Provider.of<MilkProvider>(context, listen: false)
//             .incrementCount('Yogurt');
//       },
//     ),
//     MilkButton(
//       productType: 'Butter',
//       onPressed: () {
//         Provider.of<MilkProvider>(context, listen: false)
//             .incrementCount('Butter');
//       },
//     ),
//     SizedBox(height: 20),
//     MilkCounter(productType: 'Buffalo Milk'),
//     MilkCounter(productType: 'Cow Milk'),
//     MilkCounter(productType: 'Yogurt'),
//     MilkCounter(productType: 'Butter'),
//   ],
// ),

//     );
//   }
// }

// class MilkButton extends StatelessWidget {
//   final String productType;
//   final VoidCallback onPressed;

//   const MilkButton({required this.productType, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text('Add $productType'),
//     );
//   }
// }

// class MilkCounter extends StatelessWidget {
//   final String productType;

//   const MilkCounter({required this.productType});

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       '$productType Count: ${Provider.of<MilkProvider>(context).getCount(productType)}',
//       style: TextStyle(fontSize: 20),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Item {
  String name;
  double price;

  Item({required this.name, required this.price});
}

class ItemQuantity {
  Item item;
  int quantity;

  ItemQuantity({required this.item, required this.quantity});
}

class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  List<ItemQuantity> _itemQuantities = [];
  List<Item> _items = [
    Item(name: 'Item 1', price: 10.0),
    Item(name: 'Item 2', price: 20.0),
    Item(name: 'Item 3', price: 30.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Items'),
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_items[index].name),
            subtitle: Text('\$${_items[index].price}'),
            trailing: DropdownButton<int>(
              value: _itemQuantities
                      .firstWhere(
                          (element) => element.item == _items[index],
                          orElse: () => ItemQuantity(item: _items[index], quantity: 0))
                      .quantity,
              items: List.generate(10, (i) => i + 1)
                  .map((quantity) => DropdownMenuItem<int>(
                        value: quantity,
                        child: Text(quantity.toString()),
                      ))
                  .toList(),
              onChanged: (int? value) {
                setState(() {
                  _itemQuantities.removeWhere((element) => element.item == _items[index]);
                  if (value != 0) {
                    _itemQuantities.add(ItemQuantity(item: _items[index], quantity: value!));
                  }
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Do something with _itemQuantities
          print(_itemQuantities);
        },
        label: Text('Checkout'),
        icon: Icon(Icons.check),
      ),
    );
  }
}
