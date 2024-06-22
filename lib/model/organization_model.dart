class OrganizationModel{
  final String orgCode;
  final String orgName;

  OrganizationModel({required this.orgCode, required this.orgName});

  factory OrganizationModel.fromJson(Map<String, dynamic> json) {
    return OrganizationModel(
      orgCode: json['org_code'],
      orgName: json['org_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'org_code': orgCode,
      'org_name': orgName,
    };
  }
}