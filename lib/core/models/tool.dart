
class ToolModel {
  String? id;
  String? name;
  String? description;
  String? specifications;
  String? photoUrl;
  List<String>? images;
  num? fee;

  ToolModel({
    this.id,
    this.name,
    this.description,
    this.specifications,
    this.photoUrl,
    this.fee,
    this.images=const [],
  });

  factory ToolModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    List<String> tempList = [];
    for(var element in data["images"]){
      tempList.add("${element}");
    }

    return ToolModel(
        id: data['id'],
      name: data["name"],
      description: data["description"],
      photoUrl: data["photoUrl"],
      specifications: data["specifications"],
      fee: num.tryParse("${data["fee"]}"),
      images: tempList,

    );
  }

  factory ToolModel.init() {
    return ToolModel();
  }

  Map<String, dynamic> toJson() {


    return{
      'id': id,
    'name': name,
    'description': description,
    'specifications': specifications,
    'photoUrl': photoUrl,
    'images': images,
    'fee': fee,
  };
  }
}

///Tools
class Tools {
  List<ToolModel> items;



  Tools({required this.items});

  factory Tools.fromJson(json) {
    List<ToolModel> temp = [];
    for (int i = 0; i < json.length; i++) {
      ToolModel tempElement = ToolModel.fromJson(json[i]);
      tempElement.id = json[i].id;
      temp.add(tempElement);
    }
    return Tools(items: temp);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> temp = [];
    for (var element in items) {
      temp.add(element.toJson());
    }
    return {
      'items': temp,
    };
  }
}