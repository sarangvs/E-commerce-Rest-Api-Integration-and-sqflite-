import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:retailer_app/view/retailer_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Welcome",
          style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              _retailerCard("Samsung"),
              _retailerCard("Lg"),
              _retailerCard("Whirlpool")
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _retailerCard(String name) {
    return GestureDetector(
      onTap: () {
        Get.to(() => RetailerView(
              retailerName: name,
            ));
      },
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[300],
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(12),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset("assets/images/error-image.jpeg", height: 80),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const Text("8848561783"),
                        const Text("test@gmail.com"),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Check In"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
