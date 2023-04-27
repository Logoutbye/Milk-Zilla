import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class FirestoreHelper {
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;

//   static Future<Map<String, dynamic>?> getDocumentData(
//       String collectionName, String documentID) async {
//     DocumentReference documentReference =
//         firestore.collection(collectionName).doc(documentID);
//     DocumentSnapshot documentSnapshot = await documentReference.get();

//     if (documentSnapshot.exists) {
//       Map<String, dynamic>? data =
//           documentSnapshot.data() as Map<String, dynamic>?;
//       return data;
//     } else {
//       return null;
//     }
//   }

// use this method
//   getData() async {
//   final user = FirebaseAuth.instance.currentUser;
//   Map<String, dynamic>? data =
//       await FirestoreHelper.getDocumentData('Sellers', '${user!.email}');
//   if (data != null) {
//     String field1Value = data['status'];
//     print('field1 value: $field1Value');
//   } else {
//     print('Document does not exist');
//   }
// }
// }

class FirestoreHelper {
  static String currentSellerStatusInFirestore = '';

  static Future<void> initializeToCheckStatusForSellers() async {
    //to get Current user email to access the application status
    final user = FirebaseAuth.instance.currentUser;
    // to access the document
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference documentReference =
        firestore.collection('Sellers').doc('${user?.email}');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      currentSellerStatusInFirestore = data!['status'];
    }
  }

  
  static String currentInspectorStatusInFirestore = '';
  static Future<void> initializeToCheckStatusForInspector() async {
    //to get Current user email to access the application status
    final user = FirebaseAuth.instance.currentUser;
    // to access the document
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference documentReference =
        firestore.collection('Inspectors').doc('${user?.email}');
    DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      currentInspectorStatusInFirestore = data!['status'];
    }
  }
}

// void main() async {
//   await MyClass.initialize();
//   print(MyClass.field1);
// }

  // // initialize Firestore
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

  // // get document reference
  // DocumentReference documentReference = firestore.collection('my_collection').doc('my_document');

  // // get document snapshot
  // DocumentSnapshot documentSnapshot = await documentReference.get();

  // // check if document exists
  // if (documentSnapshot.exists) {
  //   // get document data
  //   Map<String, dynamic> data = documentSnapshot.data();

  //   // access specific fields
  //   String field1Value = data['field1'];
  //   int field2Value = data['field2'];

  //   // print field values
  //   print('field1 value: $field1Value');
  //   print('field2 value: $field2Value');
  // } else {
  //   print('Document does not exist');
  // }
