class CategoriesModel {
  late int category_id;
  late String category_name;
  late String category_photo;

  CategoriesModel(this.category_id, this.category_name, this.category_photo);

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    category_id = json["category_id"];
    category_name = json["category_name"];
    category_photo = json["category_photo"];
  }
}
