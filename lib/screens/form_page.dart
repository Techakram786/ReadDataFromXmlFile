import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nic_assigment/controllers/form_cotroller.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final FormController formController = Get.put(FormController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formController.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: formController.textController.value,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Enter Pensioner Name',
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    hintStyle: const TextStyle(color: Colors.black),
                    labelStyle: const TextStyle(color: Colors.black),
                    filled: false,
                    fillColor: Colors.grey[70],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                      const BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide:
                      const BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    } else if (value.length < 2) {
                      return 'Minimum 2 characters required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 22.0),
                Obx(() {
                  return DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      labelText: 'Select Organization',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[50],
                      // Light gray background
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    items: formController.organizations.map((organization) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          formController.dropdownValue1!.value = "";
                          formController.isDropdown1Selected.value = false;
                          formController.showFilterList(organization.orgCode);
                        },
                        value: organization.orgCode,
                        child: Text(organization.orgName),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        formController.dropdownValue!.value = newValue;
                      }
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Select Organization';
                      }
                      return null;
                    },
                  );
                }),
                const SizedBox(height: 22.0),
                Obx(() {
                  if (formController.filteredAuthorityList.isNotEmpty) {
                    return DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Sanctioning Authority',
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        hintStyle: const TextStyle(color: Colors.black),
                        labelStyle: const TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                        ),
                      ),
                      value: formController.dropdownValue1!.value.isNotEmpty
                          ? formController.dropdownValue1?.value
                          : null,
                      items:
                      formController.filteredAuthorityList.map((authority) {
                        return DropdownMenuItem<String>(
                          value: authority.authorityCode,
                          child: Text(authority.authorityName),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          formController.dropdownValue1?.value = value;
                          var selectedAuthority = formController
                              .filteredAuthorityList
                              .firstWhere((authority) =>
                          authority.authorityCode == value);
                          formController.validChar.value =
                              RegExp(selectedAuthority.ppoValidChar);
                          List<String> lengths =
                          selectedAuthority.ppoValidLength.split('|');
                          formController.minLength.value = int.parse(lengths[0]);
                          formController.maxLength.value = int.parse(lengths[1]);
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Select Authority';
                        }
                        return null;
                      },
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: 22.0),
                Obx(() {
                  return TextFormField(
                    controller: formController.nameTextController.value,
                    decoration: InputDecoration(
                      labelText: 'Enter PPO Number',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      hintStyle: const TextStyle(color: Colors.black),
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide:
                        const BorderSide(color: Colors.blue, width: 2.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      } else if (value.length < formController.minLength.value) {
                        return 'Minimum ${formController.minLength
                            .value} characters required';
                      } else if (value.length > formController.maxLength.value) {
                        return 'Maximum ${formController.maxLength
                            .value} characters allowed';
                      } else if (!formController.validChar.value
                          .hasMatch(value)) {
                        return 'Only alphanumeric characters are allowed';
                      }
                      return null;
                    },
                  );
                }),
                const SizedBox(height: 22.0),
                Obx(() {
                  return Row(
                    children: [
                      const Text(
                        'Are You Re-Employed?',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      const SizedBox(width: 10,
                      ),
                      Flexible(
                        child: RadioListTile<bool>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: -3, vertical: -4),
                          title: const Text('Yes'),
                          value: true,
                          groupValue: formController.isReEmployed.value,
                          onChanged: (bool? value) {
                            if (value != null) {
                              formController.isReEmployed.value = value;
                            }
                          },
                        ),
                      ),
                      Flexible(
                        child: RadioListTile<bool>(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          visualDensity:
                          const VisualDensity(horizontal: -3, vertical: -4),
                          title: const Text('No'),
                          value: false,
                          groupValue: formController.isReEmployed.value,
                          onChanged: (bool? value) {
                            if (value != null) {
                              formController.isReEmployed.value = value;
                            }
                          },
                        ),
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 32.0),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formController.formKey.currentState!.validate()) {
                        if (formController.isReEmployed.isTrue) {
                          formController.showAlertDialog(context);
                        }
                        else{
                          formController.submitForm(context);
                        }
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
