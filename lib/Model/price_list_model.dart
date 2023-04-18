class PriceList {
  String? cow_milk;
  String? buffalo_milk;
  String? mix_milk;
  String? yougurt;
  String? butter;
  String? desi_ghee;

  PriceList({
    required this.cow_milk,
    required this.buffalo_milk,
    required this.mix_milk,
    required this.yougurt,
    required this.desi_ghee,
  });

  PriceList.fromJson(Map<String, dynamic> json) {
    cow_milk = json['cow_milk'];
    buffalo_milk = json['buffalo_milk'];
    mix_milk = json['mix_milk'];
    yougurt = json['yougurt'];
    desi_ghee = json['desi_ghee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cow_milk'] = this.cow_milk;
    data['buffalo_milk'] = this.buffalo_milk;
    data['mix_milk'] = this.mix_milk;
    data['yougurt'] = this.yougurt;
    data['desi_ghee'] = this.desi_ghee;
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