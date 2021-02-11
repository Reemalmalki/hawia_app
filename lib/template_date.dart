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
      description: "",
      images: []),
  templatedata(1,
      name: "قالب بوربوينت",
      iconImage: 'assets/powerpoint.png',
      description: "",
      images: []),
  templatedata(2,
      name: "قالب وورد انجليزي",
      iconImage: 'assets/word.png',
      description: "",
      images: []),
];

List<templatedata> templatesHome = [
  templatedata(0, name: "A4", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(1, name: "Banner ", iconImage: 'assets/illustrator.png', description: "", images: []),
];

List<templatedata> signBoards = [
  templatedata(0, name: "لوحة ارشادية داخلية", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(1, name: "لوحة ارشادية خارجية", iconImage: 'assets/illustrator.png', description: "", images: []),
];

List<templatedata> certification = [
  templatedata(0, name: "شهادات الشكر", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(1, name: "الدروع التكريمية", iconImage: 'assets/illustrator.png', description: "", images: []),
];

List<templatedata> publications = [
  templatedata(0, name: "مجلد", iconImage:'assets/pdf.png', description: "", images: []),
  templatedata(1, name: "بطاقات التهاني", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(2, name: "خلفية مسارح", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(3, name: "ملصقات جدارية", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(4, name: "حامل اعلانات", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(5, name: "راية الفعاليات", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(6, name: "طباعة الشعار على الهدايا١", iconImage: 'assets/jpeg.png', description: "", images: []),
  templatedata(7, name: "طباعة الشعار على الهدايا٢", iconImage: 'assets/jpeg.png', description: "", images: []),
  templatedata(8, name: "طباعة الدرع على الهدايا١", iconImage: 'assets/jpeg.png', description: "", images: []),
  templatedata(9, name: "طباعة الدرع على الهدايا٢", iconImage: 'assets/jpeg.png', description: "", images: []),


];

//PartnersAnd Aponsors
List<templatedata> PartnersAndAponsors = [
  templatedata(0, name: "الشريك الرئيسي", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(1, name: "A4 الشريك الرئيسي", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(2, name: "الشريك المماثل", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(3, name: " A4 الشريك المماثل", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(4, name: "تعدد الرعاة", iconImage: 'assets/illustrator.png', description: "", images: []),

  templatedata(5, name: " A4 تعدد الرعاة", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(6, name: "فعالية داخلية", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(7, name: "A4 فعالية داخلية", iconImage: 'assets/illustrator.png', description: "", images: []),

];

//Electronic communication
List<templatedata> electronicCommunication = [
  templatedata(0, name: "تويتر", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(1, name: "الاعلان الالكتروني(شاشات)", iconImage:'assets/illustrator.png', description: "", images: []),
  templatedata(2, name: " دليل المواقع الالكترونية ", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(3, name: "توقيع البريد الالكتروني١", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(4, name: "توقيع البريد الالكتروني٢", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(5, name: "توقيع البريد الالكتروني٣", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(6, name: "توقيع البريد الالكتروني٤", iconImage: 'assets/illustrator.png', description: "", images: []),
  templatedata(7, name: "توقيع البريد الالكتروني٥", iconImage: 'assets/illustrator.png', description: "", images: []),

];

//Official correspondence

//List<templatedata> officialCorrespondence = [
 // templatedata(0, name: "Official correspondence agency", iconImage:'', description: "", images: []),
  //templatedata(1, name: "Official correspondence college", iconImage:'', description: "", images: []),
 // templatedata(2, name: "Official correspondence deanship", iconImage: '', description: "", images: []),

//];