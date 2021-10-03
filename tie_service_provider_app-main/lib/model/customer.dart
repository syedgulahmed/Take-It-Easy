
class Customer {
  final String id;
  final String name;
  final String email;
  String imageUrl;
  final String address;

  Customer(this.id, this.name, this.email, this.imageUrl, this.address);
  Map<String, dynamic> asMap(){
    return {
      "id": id,
      "name": name,
      "email": email,
      "image": imageUrl,
      "address": address
    };
  }
}
