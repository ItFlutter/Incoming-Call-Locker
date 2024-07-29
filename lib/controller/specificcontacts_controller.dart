import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/data/model/contactsmodel.dart';

import '../core/functions/requestcontactspermission.dart';

class SpecificContactsController extends GetxController {
  bool isLoading = false;
  bool isContactPermissionsGranted = false;
  List<ContactsModel> contactsModel = [];
  List<Contact> contacts = [];
  List<ContactsModel> contactsSpecified = [];
  checkContactPermission() async {
    isContactPermissionsGranted = await requestContactsPermission();
    print("============================================================");
    print(
        "=====================================isContactPermissionsGranted=======================$isContactPermissionsGranted");
    if (isContactPermissionsGranted == true) {
      getContacts();
    }
    update();
  }

  onTapContact(int index) {
    contactsModel[index].isSelected = !contactsModel[index].isSelected;
    if (contactsModel[index].isSelected == true) {
      contactsSpecified.add(contactsModel[index]);
      print(
          "=======================================Add=================================${contactsSpecified[contactsSpecified.length - 1].name}");
      print(
          "========================================contactsSpecified================================$contactsSpecified");
    } else {
      print(
          "=======================================Remove=================================${contactsSpecified[contactsSpecified.length - 1].name}");
      contactsSpecified.remove(contactsModel[index]);
      print(
          "========================================contactsSpecified================================$contactsSpecified");
    }
    update();
  }

  getContacts() async {
    isLoading = true;
    contacts = await ContactsService.getContacts();
    print("============================================================");
    print(
        "=====================================contacts=======================${contacts}");
    if (contacts.isNotEmpty) {
      contactsModel.addAll(contacts.map((e) => ContactsModel(
          name: e.displayName,
          phone: e.phones!.isNotEmpty
              ? (e.phones?[0].label == "mobile"
                  ? (e.phones?[0].value)
                  : "UnKnown")
              : "UnKnown",
          isSelected: false)));
      print("============================================================");
      print(
          "=====================================contactsModel=======================$contactsModel");
    } else {
      Get.snackbar("warning", "Something went wrong");
    }
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    checkContactPermission();
    // TODO: implement onInit
    super.onInit();
  }
}
