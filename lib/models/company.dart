class Company {
  final String id;
  final String name;
  final int? type;

  Company(this.id, this.name, this.type);

  Company.fromJson(Map<String, dynamic> json)
      : id = json["Id"],
        name = json["Name"],
        type = json["Type"];

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Name": name,
        "Type": type,
      };
}
