class Cusers {
  String Name;

  String LastName;

  String Url;
  Cusers({required this.Name, required this.LastName, required this.Url});
  factory Cusers.fromJson(Map<String, dynamic> json) => Cusers(
        Name: json["name"],
        LastName: json["lastname"],
        Url: json["url"],
      );
}
