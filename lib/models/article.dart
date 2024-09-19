class Article{
  String ?title;
  String ?urlToImage;
  String ?description;
  Article({ this.title, this.urlToImage, this.description});

  factory Article.fromJson(Map<String,dynamic> jsonData){
    String title = jsonData["title"]?? "generic Title";
    String urlToImage = jsonData["urlToImage"]??"";
    String description = jsonData["description"]??"Generic description";
    return Article(title: title,urlToImage: urlToImage,description: description);
  }
}