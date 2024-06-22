import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xml/xml.dart' as xml;
import 'package:flutter/services.dart' show rootBundle;
import '../model/authority_model.dart';
import '../model/organization_model.dart';

class FormController extends GetxController {
  //todo Controllers for form fields
  var nameTextController = TextEditingController().obs;
  var textController = TextEditingController().obs;

  //todo Form key to validate form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var validChar = RegExp(r'').obs; //todo Define the regular expression
  RxInt minLength = 0.obs;
  RxInt maxLength = 0.obs;
  var isReEmployed = false.obs; // todo Initial value is false (No is selected)

  // todo List to hold organization data
  // Reactive dropdown value
  RxString? dropdownValue = ''.obs;
  RxString? dropdownValue1 = ''.obs;
  RxBool isDropdown1Selected = false.obs;

  // todo List to hold organization data
  late final RxList<OrganizationModel> organizations = <OrganizationModel>[].obs;
  late final RxList<AuthorityModel> authorityList = <AuthorityModel>[].obs;
  late final RxList<AuthorityModel> filteredAuthorityList = <AuthorityModel>[].obs;

  // Constructor
  FormController() {
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final xmlString = await rootBundle.loadString('assets/xml/XML.txt');
      final jsonArrays = await parseXmlToJson(xmlString);
      organizations.addAll(jsonArrays[0].map<OrganizationModel>((data) => OrganizationModel.fromJson(data)).toList());
      authorityList.addAll(jsonArrays[1].map<AuthorityModel>((data) => AuthorityModel.fromJson(data)).toList());
      if (organizations.isNotEmpty) {
        dropdownValue!.value = organizations[0].orgCode;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error loading XML data: $e");
      }
    }
  }

  Future<List<List<dynamic>>> parseXmlToJson(String xmlString) async {
    final document = xml.XmlDocument.parse(xmlString);

    final organizations = document.findAllElements('organisation').map((element) {
      return element.findElements('item').map((item) {
        return {
          'org_code': item.findElements('org_code').single.text,
          'org_name': item.findElements('org_name').single.text,
        };
      }).toList();
    }).expand((i) => i).toList();

    final authorities = document.findAllElements('authority').map((element) {
      return element.findElements('item').map((item) {
        return {
          'org_code': item.findElements('org_code').single.text,
          'authority_code': item.findElements('authority_code').single.text,
          'authority_name': item.findElements('authority_name').single.text,
          'valid_rule': item.findElements('valid_rule').single.text,
          'rule_status': item.findElements('rule_status').single.text,
          'ppo_valid_char': item.findElements('ppo_valid_char').single.text,
          'ppo_valid_length': item.findElements('ppo_valid_length').single.text,
        };
      }).toList();
    }).expand((i) => i).toList();

    return [organizations, authorities];
  }

  //todo Validate and submit the form
  void submitForm(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted')),
      );
    }
  }

  // authorityList without filter 2nd dropdown data
  // filteredAuthorityList filter 2nd dropdown data
  Future<void> showFilterList(String orgCode) async {
    try {
      isDropdown1Selected.value = true;
      if (authorityList.isNotEmpty) {
        filteredAuthorityList.clear();
        filteredAuthorityList.value = authorityList
            .where((authority) => authority.orgCode == orgCode)
            .toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print("error: $e");
      }
    }
  }

  void showAlertDialog(BuildContext context) {
    // Set up the AlertDialog
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Alert"),
            content: const Text(
                "You are not allowed to generate DLC in case of Re-employment"),
            actions: [
              TextButton(
                child: const Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        });
  }
}
