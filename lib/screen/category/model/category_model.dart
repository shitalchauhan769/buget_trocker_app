

class CategoryModel
{
  int? id;
  String? name;

  CategoryModel({this.id, this.name});
  factory CategoryModel.MapToModel(Map m1)
  {
    return CategoryModel(id: m1['cid'],name: m1['name']);
  }
}