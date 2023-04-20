class PriceList {
  var cow_milk;
  var buffalo_milk;
  var mix_milk;
  var yougurt;
  var butter;
  var desi_ghee;
  var delivery_charges;

  PriceList({
    required this.cow_milk,
    required this.buffalo_milk,
    required this.mix_milk,
    required this.yougurt,
    required this.desi_ghee,
    required this.delivery_charges,
    required this.butter,
  });

  PriceList.fromJson(Map<String, dynamic> json) {
    cow_milk = json['cow_milk'];
    buffalo_milk = json['buffalo_milk'];
    mix_milk = json['mix_milk'];
    yougurt = json['yougurt'];
    desi_ghee = json['desi_ghee'];
    butter = json['butter'];
    delivery_charges = json['delivery_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cow_milk'] = this.cow_milk;
    data['buffalo_milk'] = this.buffalo_milk;
    data['mix_milk'] = this.mix_milk;
    data['yougurt'] = this.yougurt;
    data['desi_ghee'] = this.desi_ghee;
    data['butter'] = this.butter;
    data['delivery_charges'] = this.delivery_charges;
    return data;
  }

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
