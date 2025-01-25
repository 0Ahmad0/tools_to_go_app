
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tools_to_go_app/core/models/review_model.dart';

import '../../app/features/profile/controller/profile_controller.dart';

class ToolModel {
  String? id;
  String? idOwner;
  String? name;
  String? description;
  String? specifications;
  String? photoUrl;
  List<String>? images;
  num? fee;
  List<ReviewModel>? reviews;

  ToolModel({
    this.id,
    this.idOwner,
    this.name,
    this.description,
    this.specifications,
    this.photoUrl,
    this.fee,
    this.images=const [],
    this.reviews,
  });
  double get  getRate{
    double rate=0;
    if(reviews?.isEmpty??true)
      return 0;
    for(ReviewModel review in reviews??[]){
      rate+=review.avgRate;
    }
    return rate/(reviews?.length??1);
  }

  double? get  getRateUser{

    return reviews?.where((e)=>e.idUser==Get.put(ProfileController()).currentUser?.value?.uid)?.firstOrNull?.avgRate;
  }

  factory ToolModel.fromJson(json) {
    var data = ['_JsonDocumentSnapshot','_JsonQueryDocumentSnapshot'].contains(json.runtimeType.toString())?json.data():json;
    List<String> tempList = [];
    for(var element in data["images"]){
      tempList.add("${element}");
    }

    List<ReviewModel> tempListReviews = [];

    for(var review in data["reviews"]??[]){
      tempListReviews.add(ReviewModel.fromJson(review));
    }

    return ToolModel(
        id: data['id'],
        idOwner: data['idOwner'],
      name: data["name"],
      description: data["description"],
      photoUrl: data["photoUrl"],
      specifications: data["specifications"],
      fee: num.tryParse("${data["fee"]}"),
      images: tempList,
      reviews: tempListReviews

    );
  }

  factory ToolModel.init() {
    return ToolModel();
  }

  Map<String, dynamic> toJson() {

    List<Map<String, dynamic>> tempListReviews = [];
    for(ReviewModel review in reviews??[]){
      tempListReviews.add(review.toJson());
    }
    return{
      'id': id,
      'idOwner': idOwner,
    'name': name,
    'description': description,
    'specifications': specifications,
    'photoUrl': photoUrl,
    'images': images,
    'fee': fee,
      'reviews':tempListReviews
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