import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/user.dart';

Future<String> getData(String email) async {
  try {
    final DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore.instance.collection('user').doc(email).get();
    //print(doc.get('data'));
    if (doc.data() != null) {
      MyUser.data = doc.get('data');
      MyUser.phoneNumber = doc.get('phone');
      // print('data : ${MyUser.data}');
      // print('server : ${doc.get('data').runtimeType}');
      // print('user : ${MyUser.data.runtimeType}');
      return 'Success';
    }
    return 'Data Fetching error. recieved Null';
  } on FirebaseException catch (e) {
    return e.code;
  } catch (e) {
    return e.toString();
  }
}

Future<String> saveData(String email) async {
  try {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(email)
        .set({'phone': MyUser.phoneNumber.toString(), 'data': MyUser.data});
    return MyConstants.signupSuccess;
  } on FirebaseException catch (e) {
    return e.code;
  }
}

Future<String> databaseUpdate(String email, fieldName, var newValue) async {
  try {
    await FirebaseFirestore.instance.collection('user').doc(email).update({fieldName: newValue});
    return "Success";
  } on FirebaseException catch (e) {
    return e.code;
  }
}
