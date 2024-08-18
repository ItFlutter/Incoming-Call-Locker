import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/class/sqldb.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/data/model/contactsmodel.dart';
import '../core/functions/requestreadcontactspermission.dart';
import '../core/services/myservices.dart';

class SpecificContactsController extends GetxController {
  MyServices myServices = Get.find();

  late int selectedContactType;
  SqlDb sqlDb = Get.find();
  bool isLoading = false;
  bool isReadContactsPermissionGranted = false;
  List<ContactsModel> contactsModel = [];
  List<Contact> contacts = [];
  List<ContactsModel> contactsSpecified = [];
  List<ContactsModel> contactsSpecifiedInDb = [];

  onTapContact(int index) {
    contactsModel[index].isSelected = !contactsModel[index].isSelected;
    if (contactsModel[index].isSelected == true) {
      contactsSpecified.add(contactsModel[index]);
      print(
          "=======================================Add=================================${contactsModel[index].name}");
      print(
          "========================================contactsSpecified================================$contactsSpecified");
    } else {
      contactsSpecified
          .removeWhere((element) => element.name == contactsModel[index].name);
      print(
          "=======================================Remove=================================${contactsModel[index].name}");
      print(
          "========================================contactsSpecified================================$contactsSpecified");
    }
    update();
  }

  deleteContactsSpecifiedFromDb() async {
    if (contactsSpecifiedInDb.isNotEmpty) {
      int response;
      int same = 0;

      for (int i = 0; i < contactsSpecifiedInDb.length; i++) {
        same = 0;
        for (int j = 0; j < contactsSpecified.length; j++) {
          if (contactsSpecifiedInDb[i].name == contactsSpecified[j].name) {
            // print(
            //     "=====================================contactsSpecifiedInDb[j].name=======================${contactsSpecifiedInDb[j].name}");
            // print(
            //     "=====================================contactsSpecified[i].name=======================${contactsSpecified[i].name}");

            same++;
            break;
          }
        }
        if (same == 0) {
          response = await sqlDb.deleteData(
              "delete from incomingcalllocker where name='${contactsSpecifiedInDb[i].name}'");

          print(
              "================================ResponseDelete===========================$response");
        }
      }
      update();
    }
  }

  addContactsSpecifiedToDb() async {
    await deleteContactsSpecifiedFromDb();
    if (contactsSpecified.isNotEmpty) {
      int response;
      int similar = 0;

      for (int i = 0; i < contactsSpecified.length; i++) {
        similar = 0;
        for (int j = 0; j < contactsSpecifiedInDb.length; j++) {
          if (contactsSpecified[i].name == contactsSpecifiedInDb[j].name) {
            // print(
            //     "=====================================contactsSpecifiedInDb[j].name=======================${contactsSpecifiedInDb[j].name}");
            // print(
            //     "=====================================contactsSpecified[i].name=======================${contactsSpecified[i].name}");

            similar++;
          }
        }
        if (similar == 0) {
          response = await sqlDb.insertData(
              'insert into incomingcalllocker(name,phone,isSelected) values ("${contactsSpecified[i].name}","${contactsSpecified[i].phone}",${contactsSpecified[i].isSelected == true ? 1 : 0})');
          print(
              "================================ResponseInsert===========================$response");
        }
      }
      // print(
      //     "=====================================similar=======================$similar");
      // if (similar < contactsSpecified.length) {
      //   print(
      //       "=======================================EnterSimilar=================================");
      //   // contactsSpecified.forEach((element) async {
      //   // response = await sqlDb.insertData(
      //   //     'insert into incomingcalllocker(name,phone,isSelected) values ("${element.name}","${element.phone}",${element.isSelected == true ? 1 : 0})');
      //   // print(
      //   //     "================================Response===========================$response");
      //   // });
      //   for (int i = 0; i < contactsSpecified.length; i++) {
      //     print("for");
      //     if (contactsSpecifiedInDb.isNotEmpty) {
      //       for (int j = 0; j < contactsSpecifiedInDb.length; j++) {
      //         if (contactsSpecified[i].name == contactsSpecifiedInDb[j].name) {
      //           contactsSpecified.removeWhere(
      //               (element) => element.name == contactsSpecified[i].name);
      //           print(
      //               "=====================================contactsSpecified=======================$contactsSpecified");

      //           //delete change index need update
      //         } else {
      //           response = await sqlDb.insertData(
      //               'insert into incomingcalllocker(name,phone,isSelected) values ("${contactsSpecified[i].name}","${contactsSpecified[i].phone}",${contactsSpecified[i].isSelected == true ? 1 : 0})');
      //           print(
      //               "================================ResponseInsert===========================$response");
      //         }
      //       }
      //     } else {
      //       response = await sqlDb.insertData(
      //           'insert into incomingcalllocker(name,phone,isSelected) values ("${contactsSpecified[i].name}","${contactsSpecified[i].phone}",${contactsSpecified[i].isSelected == true ? 1 : 0})');
      //       print(
      //           "================================ResponseInsert===========================$response");
      //     }
      //   }
      // }

      // else {
      //   Get.snackbar(
      //     "Warning",
      //     "Nothing new has been added",
      //   );
      // }

      // if (response > 0) {}

      Get.offAllNamed(AppRoutes.homeScreen);

      myServices.sharedPreferences.setInt("callingsetting", 2);
    } else {
      Get.snackbar(
        "Error",
        "Please select at least one contact",
      );
    }
  }

  getContactsFromPackage() async {
    contacts = await ContactsService.getContacts();
    print("============================================================");
    print(
        "=====================================contacts=======================$contacts");
    if (contacts.isNotEmpty) {
      contactsModel.addAll(contacts.map((e) {
        if (e.phones!.isEmpty) {
          print(
              "===========================EmptyListPhones=================================");
          print(
              "=====================================name of contact empty=======================${e.displayName}");

          return ContactsModel(
              name: e.displayName ?? "UnKnown",
              // phone: e.phones!.isNotEmpty
              //     ? (e.phones?[0].label == "mobile"
              //         ? (e.phones?[0].value)
              //         : "UnKnown")
              //     : "UnKnown",
              // phone: e.phones!.isNotEmpty ? e.phones![0].value : "UnKnown",
              phone: "UnKnown",
              isSelected: false);
        } else {
          return ContactsModel(
              name: e.displayName ?? "UnKnown",
              // phone: e.phones!.isNotEmpty
              //     ? (e.phones?[0].label == "mobile"
              //         ? (e.phones?[0].value)
              //         : "UnKnown")
              //     : "UnKnown",
              // phone: e.phones!.isNotEmpty ? e.phones![0].value : "UnKnown",
              phone: e.phones![0].value ?? "UnKnown",
              isSelected: false);
        }
        ;
      }));

      print("============================================================");
      print(
          "=====================================contactsModel=======================$contactsModel");
      if (contactsSpecified.isNotEmpty) {
        for (int i = 0; i < contactsModel.length; i++) {
          for (int j = 0; j < contactsSpecified.length; j++) {
            if (contactsModel[i].name == contactsSpecified[j].name) {
              contactsModel[i].isSelected = true;
            }
          }
        }
      }
    } else {
      Get.snackbar(
          "warning", "Something went wrong you probably don't have contacts");
    }
    update();
  }

  getContactsFromDb() async {
    List<Map> data = await sqlDb.readData('select * from incomingcalllocker');
    print("============================================================");
    print(
        "=====================================data=======================$data");
    if (data.isNotEmpty) {
      contactsSpecifiedInDb.addAll(data.map((e) => ContactsModel(
          name: e['name'],
          phone: e['phone']!.isNotEmpty ? e['phone'] : "UnKnown",
          isSelected: e['isSelected'] == 1 ? true : false)));
      print("============================================================");
      print(
          "=====================================contactsSpecifiedInDb=======================$contactsSpecifiedInDb");
      contactsSpecified.addAll(contactsSpecifiedInDb);
      print("============================================================");
      print(
          "=====================================contactsSpecified=======================$contactsSpecified");
    }
    update();
  }

  checkContactPermission() async {
    isReadContactsPermissionGranted = await requestReadContactsPermission();
    print("============================================================");
    print(
        "=====================================isReadContactsPermissionGranted=======================$isReadContactsPermissionGranted");
    if (isReadContactsPermissionGranted == true) {
      await getContactsFromPackage();
    }
    update();
  }

  getData() async {
    isLoading = true;
    if (selectedContactType == 2) {
      await getContactsFromDb();
    }
    await checkContactPermission();
    isLoading = false;
    update();
  }

  @override
  void onInit() {
    selectedContactType =
        myServices.sharedPreferences.getInt("callingsetting") ?? 0;
    print("============================================================");
    print(
        "=====================================selectedContactType=======================$selectedContactType");

    getData();

    // checkContactPermission();
    // TODO: implement onInit
    super.onInit();
  }
}
