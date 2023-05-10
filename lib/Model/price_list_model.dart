import 'package:cloud_firestore/cloud_firestore.dart';

class PriceListModel {
  var cow_milk;
  var buffalo_milk;
  var mix_milk;
  var yougurt;
  var butter;
  var desi_ghee;
  var delivery_charges;

  PriceListModel({
    required this.cow_milk,
    required this.buffalo_milk,
    required this.mix_milk,
    required this.yougurt,
    required this.desi_ghee,
    required this.delivery_charges,
    required this.butter,
  });

  PriceListModel.fromJson(Map<String, dynamic> json) {
    cow_milk = json['cow_milk'];
    buffalo_milk = json['buffalo_milk'];
    mix_milk = json['mix_milk'];
    yougurt = json['yogurt'];
    desi_ghee = json['desi_ghee'];
    butter = json['butter'];
    delivery_charges = json['delivery_charges'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cow_milk'] = this.cow_milk;
  //   data['buffalo_milk'] = this.buffalo_milk;
  //   data['mix_milk'] = this.mix_milk;
  //   data['yogurt'] = this.yougurt;
  //   data['desi_ghee'] = this.desi_ghee;
  //   data['butter'] = this.butter;
  //   data['delivery_charges'] = this.delivery_charges;
  //   return data;
  // }

  //  PriceList fromJson(Map<String, dynamic> json) => PriceList(
  //     cow_milk: json['cow_milk'],
  //     buffalo_milk: json['buffalo_milk'],
  //     mix_milk: json['mix_milk'],
  //     yougurt: json['yougurt'],
  //     desi_ghee: json['desi_ghee']);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cow_milk'] = this.cow_milk;
  //   data['buffalo_milk'] = this.buffalo_milk;
  //   data['mix_milk'] = this.mix_milk;
  //   data['yougurt'] = this.yougurt;
  //   data['desi_ghee'] = this.desi_ghee;
  //   return data;
  // }
}

class ContainerPriceList {
  var quantity250ML;
  var quantity500ML;
  var quantity1L;
  var delivery_charges;

  ContainerPriceList({
    required this.quantity250ML,
    required this.quantity500ML,
    required this.quantity1L,
    required this.delivery_charges,
  });

  ContainerPriceList.fromJson(Map<String, dynamic> json) {
    delivery_charges = json['delivery_charges'];

    quantity1L = json['1 liter'];
    quantity250ML = json['250 ml'];
    quantity500ML = json['500 ml'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cow_milk'] = this.cow_milk;
  //   data['buffalo_milk'] = this.buffalo_milk;
  //   data['mix_milk'] = this.mix_milk;
  //   data['yogurt'] = this.yougurt;
  //   data['desi_ghee'] = this.desi_ghee;
  //   data['butter'] = this.butter;
  //   data['delivery_charges'] = this.delivery_charges;
  //   return data;
  // }

  //  PriceList fromJson(Map<String, dynamic> json) => PriceList(
  //     cow_milk: json['cow_milk'],
  //     buffalo_milk: json['buffalo_milk'],
  //     mix_milk: json['mix_milk'],
  //     yougurt: json['yougurt'],
  //     desi_ghee: json['desi_ghee']);

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['cow_milk'] = this.cow_milk;
  //   data['buffalo_milk'] = this.buffalo_milk;
  //   data['mix_milk'] = this.mix_milk;
  //   data['yougurt'] = this.yougurt;
  //   data['desi_ghee'] = this.desi_ghee;
  //   return data;
  // }
}
