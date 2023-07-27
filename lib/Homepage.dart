import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:savvynurse/auth/login.dart';
import 'package:savvynurse/problem_list_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> symptoms = [];
  void convertkey() {
    print(symptoms);
    print(symptoms.length);
  }

  /*Future<void> uploadlist() async {
    CollectionReference probdb =
        FirebaseFirestore.instance.collection('Problems');
    RxInt ct = 1.obs;
    Future.forEach(symptoms, ((element) {
      ct.value++;
      probdb.doc(ct.value.toString()).set({
        'name': element.toString(),
        'searchkey': element.substring(0, 1).toUpperCase().toString(),
      }).then((value) {
        print(ct);
      });
    })).then((value) {
      Get.snackbar(
          "submitted", // title
          "submitted", // message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3));
    });
  }*/
  int _current = 0;
  late List<Widget> imageSlider;
  final List imagelist = [
    "https://firebasestorage.googleapis.com/v0/b/savvynurse-c6187.appspot.com/o/WhatsApp%20Image%202022-11-05%20at%2014.49.53.jpg?alt=media&token=165bed16-85f6-4c56-a06a-93d0a2630a3c",
    "https://firebasestorage.googleapis.com/v0/b/savvynurse-c6187.appspot.com/o/WhatsApp%20Image%202022-11-05%20at%2014.56.36.jpg?alt=media&token=55056333-dfa2-4915-a53e-d0f31ff3631d",
    "https://firebasestorage.googleapis.com/v0/b/savvynurse-c6187.appspot.com/o/WhatsApp%20Image%202022-11-05%20at%2014.56.44.jpg?alt=media&token=f716ab08-f436-4067-8af3-eb672c3e5b6b",
  ];

  Future<void> signOutFromGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final FirebaseAuth auth = FirebaseAuth.instance;
    await googleSignIn.signOut();
    await auth.signOut();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageSlider = imagelist
        .map((e) => Container(
              height: 400,
              margin: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: e,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                        ),
                      ),
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savvy Nurse'),
        actions: [
          IconButton(
              onPressed: () async {
                // await uploadlist();
                // convertkey();
                await signOutFromGoogle();
                Get.offAll(const Loginscreen());
              },
              icon: const Icon(Icons.logout)),
          /*   IconButton(
              onPressed: () async {
                await uploadlist();
              },
              icon: const Icon(Icons.upload_file))*/
        ],
      ),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              CarouselSlider(
                  items: imageSlider,
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 13 / 9,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagelist.map((e) {
                  int index = imagelist.indexOf(e);
                  return Container(
                    width: 8,
                    height: 8,
                    margin:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? const Color.fromRGBO(0, 0, 0, 0.9)
                          : const Color.fromRGBO(0, 0, 0, 0.4),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
          InkWell(
            child: Card(
              child: ListTile(
                title: const Text('Mediassist'),
                subtitle: const Text('Get ai based medical assistance'),
                trailing: IconButton(
                    onPressed: () {
                      Get.to(() => const Problem_list_page());
                    },
                    icon: const Icon(Icons.arrow_forward_ios)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
