import 'package:cloud_firestore/cloud_firestore.dart';

class Searchservice {
  searchByName(String searchfield) {
    return FirebaseFirestore.instance
        .collection('Problems')
        .where('searchkey',
            isEqualTo: searchfield.substring(0, 1).toUpperCase())
        .get();
  }
}
