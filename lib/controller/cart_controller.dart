import 'package:get/get.dart';

class Flistcontroller extends GetxController {
  RxList<String> cartitems = <String>[].obs;

  void addtolist(String item) {
    if (!cartitems.contains(item)) {
      cartitems.add(item);
    }
  }
}
