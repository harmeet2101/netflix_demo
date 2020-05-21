class ProductionCountries {

  final String isoName;
  final String name;

  ProductionCountries({this.isoName,this.name});

  factory ProductionCountries.fromJson(Map<String,dynamic>json){

    return ProductionCountries(
      isoName: json['iso_3166_1'],
      name:  json['name'],
    );
  }
}