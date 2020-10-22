class templatedata {
  final int position;
  final String name;
  final String iconImage;
  final String description;
  final List<String> images;

  templatedata(this.position,
      {this.name, this.iconImage, this.description, this.images});
}

List<templatedata> templates = [
  templatedata(0,
      name: "قالب وورد",
      iconImage: 'assets/word.png',
      description: "....",
      images: []),
  templatedata(1,
      name: "قالب بوربوينت",
      iconImage: 'assets/powerpoint.png',
      description: "...",
      images: []),
];
