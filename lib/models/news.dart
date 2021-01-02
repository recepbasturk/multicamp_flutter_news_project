class News {
  String title;
  String link;
  String imageUrl;
  String description;
  DateTime pubDate;

  News({
    this.title,
    this.link,
    this.imageUrl,
    this.description,
    this.pubDate,
  });

  @override
  String toString() {
    return 'News{title: $title, link: $link, imageUrl: $imageUrl, description: $description, pubDate: $pubDate}';
  }
}
