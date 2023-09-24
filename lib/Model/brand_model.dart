// ignore_for_file: public_member_api_docs, sort_constructors_first
class Brand {
  bool claimed;
  String name;
  String domain;
  dynamic? icons;
  String brandId;

  Brand({
    required this.claimed,
    required this.name,
    required this.domain,
    required this.icons,
    required this.brandId,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {

    if(json['icon'].runtimeType != List<String>){
      var icon = json['icon'].toString() ?? null;

      return Brand(
      claimed: json['claimed'] ?? false,
      name: json['name'] ?? '',
      domain: json['domain'] ?? '',
      icons: icon ,
      brandId: json['brandId'] ?? '',
    );
      
    }else{
      
      var iconsList = json['icon'] as List<String>;
      List<String> iconUrls = iconsList.map((icon) => icon.toString()).toList();

      return Brand(
      claimed: json['claimed'] ?? false,
      name: json['name'] ?? '',
      domain: json['domain'] ?? '',
      icons: iconUrls,
      brandId: json['brandId'] ?? '',
    );
    }
    
  }

  @override
  String toString() {
    return 'Brand(claimed: $claimed, name: $name, domain: $domain, icons: $icons, brandId: $brandId)';
  }
}
