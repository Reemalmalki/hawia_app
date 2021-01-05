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
      name: "قالب وورد عربي",
      iconImage: 'assets/word.png',
      description: "....",
      images: []),
  templatedata(1,
      name: "قالب بوربوينت",
      iconImage: 'assets/powerpoint.png',
      description: "...",
      images: []),
  templatedata(2,
      name: "قالب وورد انجليزي",
      iconImage: 'assets/word.png',
      description: "....",
      images: []),
];

List<templatedata> templatesHome = [
  templatedata(0, name: "A4", iconImage:'', description: "", images: []),
  templatedata(1, name: "Banner ", iconImage: '', description: "", images: []),
];

List<templatedata> signBoards = [
  templatedata(0, name: "لوحة ارشادية داخلية", iconImage:'', description: "", images: []),
  templatedata(1, name: "لوحة ارشادية خارجية", iconImage: '', description: "", images: []),
];

List<templatedata> certification = [
  templatedata(0, name: "شهادات الشكر", iconImage:'assets/illustration.png', description: "", images: []),
  templatedata(1, name: "الدروع التكريمية", iconImage: 'assets/illustration.png', description: "", images: []),
];

List<templatedata> publications = [
  templatedata(0, name: "ملفات", iconImage:'', description: "", images: []),
  templatedata(1, name: "بطاقات التهاني", iconImage: '', description: "", images: []),
  templatedata(2, name: "بوب اب (خلفية مسارح)", iconImage: '', description: "", images: []),
  templatedata(3, name: "ملصقات جدارية", iconImage: '', description: "", images: []),
  templatedata(4, name: "الرول اب", iconImage: '', description: "", images: []),
  templatedata(5, name: "رايات المعارض", iconImage: '', description: "", images: []),
];

//PartnersAnd Aponsors
List<templatedata> PartnersAndAponsors = [
  templatedata(0, name: "الشريك الرئيسي", iconImage:'', description: "", images: []),
  templatedata(1, name: "الشريك الرئيسي A4", iconImage:'', description: "", images: []),
  templatedata(2, name: "الشريك المماثل", iconImage: '', description: "", images: []),
  templatedata(3, name: " A4 الشريك المماثل", iconImage: '', description: "", images: []),
  templatedata(4, name: "تعدد الرعاة", iconImage: '', description: "", images: []),

  templatedata(5, name: "تعدد الرعاة A4", iconImage: '', description: "", images: []),
  templatedata(6, name: "فعالية داخلية", iconImage: '', description: "", images: []),
];

//Electronic communication
List<templatedata> electronicCommunication = [
  templatedata(0, name: "تويتر", iconImage:'', description: "", images: []),
  templatedata(1, name: "الاعلان الالكتروني(شاشات)", iconImage:'', description: "", images: []),
  templatedata(2, name: " دليل المواقع الالكترونية ", iconImage: '', description: "", images: []),
  templatedata(3, name: "توقيع البريد الالكتروني١", iconImage: '', description: "", images: []),
  templatedata(4, name: "توقيع البريد الالكتروني٢", iconImage: '', description: "", images: []),
  templatedata(5, name: "توقيع البريد الالكتروني٣", iconImage: '', description: "", images: []),
  templatedata(6, name: "توقيع البريد الالكتروني٤", iconImage: '', description: "", images: []),
  templatedata(7, name: "توقيع البريد الالكتروني٥", iconImage: '', description: "", images: []),

];

//Official correspondence

List<templatedata> officialCorrespondence = [
  templatedata(0, name: "Official correspondence agency", iconImage:'', description: "", images: []),
  templatedata(1, name: "Official correspondence college", iconImage:'', description: "", images: []),
  templatedata(2, name: "Official correspondence deanship", iconImage: '', description: "", images: []),

];