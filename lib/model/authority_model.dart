class AuthorityModel{
  final String orgCode;
  final String authorityCode;
  final String authorityName;
  final String validRule;
  final String ruleStatus;
  final String ppoValidChar;
  final String ppoValidLength;

  AuthorityModel({required this.orgCode, required this.authorityCode,required this.authorityName,
    required this.validRule,required this.ruleStatus,required this.ppoValidChar,required this.ppoValidLength});

  factory AuthorityModel.fromJson(Map<String, dynamic> json) {
    return AuthorityModel(
      orgCode: json['org_code'],
      authorityCode: json['authority_code'],
      authorityName: json['authority_name'],
      validRule: json['valid_rule'],
      ruleStatus: json['rule_status'],
      ppoValidChar: json['ppo_valid_char'],
      ppoValidLength: json['ppo_valid_length'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'org_code': orgCode,
      'authority_code': authorityCode,
      'authority_name': authorityName,
      'valid_rule': validRule,
      'rule_status': ruleStatus,
      'ppo_valid_char': ppoValidChar,
      'ppo_valid_length': ppoValidChar,
    };
  }
}