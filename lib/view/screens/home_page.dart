import 'dart:async';
import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:qoutes_app/utils/slide_quotes.dart';
import 'package:qoutes_app/utils/GlobalVar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random random = Random();
  late Timer timer;
  late String photo;

  // @override
  // void initState() {
  //   super.initState();
  //   photo =
  //       SlideQuotes.quotes[random.nextInt(SlideQuotes.quotes.length)] ;
  //   timer = Timer(const Duration(seconds: 3), () {
  //     setState(() {
  //       photo = SlideQuotes
  //           .quotes[random.nextInt(SlideQuotes.quotes.length + 1)];
  //       print('${photo}');
  //     });
  //   });
  // }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    int randomIndex = random.nextInt(SlideQuotes.quotes.length);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Life Quotes and...",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {});
            },
            icon: const Icon(Icons.favorite),
            color: Colors.red,
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(color: Colors.teal),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Life Quotes\nand Sayings",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment(0, 0.85),
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayCurve: Curves.easeOut,
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 9,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      }),
                  items: SlideQuotes.quotes
                      .map(
                        (e) => Container(
                          height: 180,
                          width: 300,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  e['img']),
                              repeat: ImageRepeat.repeat,
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Text(
                            e['title'],
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              wordSpacing: 2,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                DotsIndicator(
                  dotsCount: SlideQuotes.quotes.length,
                  position: currentIndex,
                  decorator: const DotsDecorator(
                      size: Size.square(7),
                      activeColor: Colors.white,
                      spacing: EdgeInsets.only(top: 5, right: 3),),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: GlobalVar.icons.map((e) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).pushNamed(e['routes']);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: e['color']),
                          alignment: Alignment.center,
                          child: e['icon'],
                        ),
                      ),
                      Text(
                        e['text'],
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                }).toList()),
            const SizedBox(height: 20),
            const Text(
              "Most Popular",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: w / 2 - 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image.network("https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg").image,
                          fit: BoxFit.fill
                        )
                      ),
                    ),
                    const Text(
                      "Learning Quotes",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: w / 2 - 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image.network(
                                  "https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg")
                              .image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Text(
                      "Life Quotes",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: w / 2 - 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: Image.network(
                                    "https://st2.depositphotos.com/2523411/8882/i/600/depositphotos_88824856-stock-photo-sunrise-above-the-mountains.jpg")
                                .image,
                            fit: BoxFit.fill),
                      ),
                    ),
                    const Text(
                      "Learning Quotes",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 120,
                      width: w / 2 - 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: Image.network(
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTOa9zC2Gbcv-fn-K5wuxJRI6t_65ng3eBV5vfrHKK76vMqMgmJT49n_B6bt5QcRIgH-zM&usqp=CAU")
                              .image,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Text(
                      "Life Quotes",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
