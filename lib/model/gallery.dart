class Gallery {
  String id;
  Urls urls;
  User user;
  bool isLiked;

  Gallery(this.id, this.urls, this.user, this.isLiked);
}

class User {
  String name;

  User(this.name);
}

class Urls {
  String regular;

  Urls(this.regular);
}
