// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import '../../Model/price_list_model.dart';

// class getDataOfLoginedCustomerController {
//   var getUserName;

//   final user = FirebaseAuth.instance.currentUser;

//   // to get current user name customer id
//   Future<PriceListModel?> getDataOfLoginedUser() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     // get document reference
//     DocumentReference documentReference =
//         firestore.collection('Buyers').doc('${user!.email}');
//     // get document snapshot
//     DocumentSnapshot documentSnapshot = await documentReference.get();
//     // check if document exists
//     if (documentSnapshot.exists) {
//       // get document data
//       Map<String, dynamic>? data =
//           documentSnapshot.data() as Map<String, dynamic>?;
//       // access specific fields
//       String user_name = data!['name'];
//       print('user_name${user_name}');
//       getUserName = user_name;
//       print('getUserName:$getUserName');
//     }
//   }
// }
