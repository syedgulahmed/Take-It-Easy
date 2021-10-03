
class Category {
  final String title;
  final String imageUrl;
  final String description;
  final String id;

  Category(this.id, this.title, this.imageUrl, this.description);

  Map<String, dynamic> asMap(){
    return {
      "id": id,
      "title": title,
      "image": imageUrl,
      "description": description
    };
  }
}
