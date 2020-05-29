class SourceModel {
  String title;
  String value;

  SourceModel(this.title, this.value);
}

// this is a static list of sources and can be replaced with dynamic list whenever we get Api which contain sources
List<SourceModel> sourceList = [
  new SourceModel("All", null),
  new SourceModel("CNN", "cnn"),
  new SourceModel("Techcrunch", "techcrunch"),
  new SourceModel("CBS News", "cbs-news"),
  new SourceModel("Fox News", "fox-news"),
  new SourceModel("Washington Post", "the-washington-post"),
  new SourceModel("TechRadar", "techradar"),
  new SourceModel("TOI", "the-times-of-India"),
  new SourceModel("The Hindu", "the-hindu"),
];
