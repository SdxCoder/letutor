

class Level {
  final String id;
  final String name;

  Level({this.id, this.name});

 Level.fromJson(Map<String, dynamic> json) :
    id = json['id'],
    name = json['name'];
  

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

   @override
  String toString() {
    super.toString();
    return name;
  }
}
