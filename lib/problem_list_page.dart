import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savvynurse/Final_list_page.dart';
import 'package:savvynurse/controller/cart_controller.dart';
import 'package:savvynurse/services/search_Service.dart';

class Problem_list_page extends StatefulWidget {
  const Problem_list_page({super.key});

  @override
  State<Problem_list_page> createState() => _Problem_list_pageState();
}

class _Problem_list_pageState extends State<Problem_list_page> {
  TextEditingController problemsetcontroller = TextEditingController();
  Flistcontroller flistcontroller = Get.put(Flistcontroller());
  var queryresult = [];
  var tempsearchstore = [];
  var backupstore = [];
  bool isLoaded = false;

  searchoperation(value) {
    if (value.length == 0) {
      setState(() {
        // isLoaded = false;
        queryresult = [];
        tempsearchstore = backupstore;
      });
    }
    var capitalizedvalue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryresult.isEmpty && value.length == 1) {
      setState(() {
        tempsearchstore = [];
      });
      Searchservice().searchByName(value).then((QuerySnapshot documents) {
        for (int i = 0; i < documents.docs.length; ++i) {
          queryresult.add(documents.docs[i].data());
          setState(() {
            tempsearchstore.add(queryresult[i]);
            isLoaded = true;
          });
        }
      });
    } else {
      tempsearchstore = [];
      for (var element in queryresult) {
        if (element['name'].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element['name'].toLowerCase().indexOf(value.toLowerCase()) == 0) {
            setState(() {
              tempsearchstore.add(element);
              isLoaded = true;
            });
          }
        }
      }
    }
  }

  Future<void> getbackupstore() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('Problems').get();
    setState(() {
      backupstore = snap.docs;
    });
  }

  @override
  void initState() {
    super.initState();
    getbackupstore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Problem List'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const Final_list_page());
            },
            icon: Stack(
              children: <Widget>[
                const Icon(
                  Icons.inventory_outlined,
                  size: 35,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Obx(
                      () => Text(
                        flistcontroller.cartitems.length.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.search),
                  title: TextField(
                    controller: problemsetcontroller,
                    decoration: const InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: (val) {
                      setState(() {
                        searchoperation(val);
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {
                      setState(() async {
                        problemsetcontroller.clear();
                        // await getcomplain();
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Builder(builder: (context) {
            return Expanded(
                child: isLoaded == true
                    ? ListView.builder(
                        itemCount: tempsearchstore.length,
                        itemBuilder: (context, index) {
                          if (tempsearchstore != null) {
                            var ds = tempsearchstore[index];
                            return InkWell(
                              onTap: () {
                                flistcontroller.addtolist(ds['name']);
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(ds['name']),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("No Problems Found"),
                            );
                          }
                        })
                    : ListView.builder(
                        itemCount: backupstore.length,
                        itemBuilder: (context, index) {
                          if (backupstore != null) {
                            var ds = backupstore[index];
                            return InkWell(
                              onTap: () {
                                flistcontroller.addtolist(ds['name']);
                              },
                              child: Card(
                                child: ListTile(
                                  title: Text(ds['name']),
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: Text("No Problems Found"),
                            );
                          }
                        }));
          }),
        ],
      )),
    );
  }
}
