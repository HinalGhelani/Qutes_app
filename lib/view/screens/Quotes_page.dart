import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qoutes_app/helper/helper_class.dart';
import 'package:qoutes_app/modal/quotes_Modals.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../utils/slide_quotes.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool starTap = false;
  Random random = Random();

  late Timer timer;
  late String photo;
  late String bg;
  String copy = "";
  GlobalKey imageKey = GlobalKey();
  TextEditingController myText = TextEditingController();

  Future saveImage(Uint8List bytes) async {
    await ImageGallerySaver.saveImage(bytes, name: "data", quality: 100);
  }

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    photo = SlideQuotes.randomImage[random.nextInt(
      SlideQuotes.randomImage.length,
    )];
    bg = SlideQuotes.randomImage[random.nextInt(
      SlideQuotes.randomImage.length,
    )];
  }

  void saveNetworkImage() async {
    GallerySaver.saveImage(bg).then((success) {
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Save Image in Gallery",
            ),
          ),
        );
        print("============Image Save");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    String data = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(data),
      ),
      body: FutureBuilder(
        future: APIHelper.apiHelper.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            print(snapshot.data);
            List<Quotes>? data = snapshot.data;
            return (data != null)
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 460,
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            RepaintBoundary(
                              key: imageKey,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                height: 400,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(bg),
                                    fit: BoxFit.fill,
                                  ),
                                  // color: Colors.teal,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 14,
                                      spreadRadius: 0.9,
                                      offset: Offset(0.7, 0.7),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      copy =
                                          "${data[i].quote} \n     -${data[i].author}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontFamily: "Kanit"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 60,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 14,
                                    spreadRadius: 0.9,
                                    offset: Offset(0.7, 0.7),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        bg = SlideQuotes.randomImage[
                                            random.nextInt(SlideQuotes
                                                .randomImage.length)];
                                        print(
                                            "=================================");
                                        print(bg);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.photo,
                                      color: Colors.orange,
                                      size: 30,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showMenu(
                                        context: context,
                                        position: const RelativeRect.fromLTRB(
                                            180, 566, 90, 100),
                                        items: [
                                          PopupMenuItem(
                                            onTap: () {
                                              Clipboard.setData(
                                                  ClipboardData(text: copy));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Copied to Clipboard"),
                                                ),
                                              );
                                            },
                                            child: const Text("Copy Text"),
                                          ),
                                          PopupMenuItem(
                                            onTap: () {
                                              Share.share('"${data[i].quote}"');
                                            },
                                            child: const Text("Share as Text"),
                                          ),
                                        ],
                                      );
                                    },
                                    child: const Icon(
                                      Icons.file_copy_sharp,
                                      color: Colors.blue,
                                      size: 25,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      RenderRepaintBoundary boundary = imageKey
                                              .currentContext!
                                              .findRenderObject()
                                          as RenderRepaintBoundary;
                                      var img =
                                          await boundary.toImage(pixelRatio: 5);
                                      var bit = await img.toByteData(
                                          format: ImageByteFormat.png);
                                      var uList = bit!.buffer.asUint8List();

                                      if (uList != null) {
                                        Directory dir =
                                            await getApplicationDocumentsDirectory();
                                        DateTime date = DateTime.now();
                                        File file = await File(
                                                "${dir.path}/FA${date.year}${date.month}${date.day}${date.hour}${date.minute}${date.second}.png")
                                            .create();
                                        await file.writeAsBytes(uList);

                                        Share.shareXFiles([XFile(file.path)]);
                                      }
                                    },
                                    child: const Icon(
                                      Icons.share,
                                      color: Colors.red,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      Uint8List? imageBytes =
                                          await screenshotController
                                              .captureFromWidget(
                                        Stack(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              height: 400,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                image: DecorationImage(
                                                  image: NetworkImage(bg),
                                                  fit: BoxFit.fill,
                                                ),
                                                // color: Colors.teal,
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    blurRadius: 14,
                                                    spreadRadius: 0.9,
                                                    offset: Offset(0.7, 0.7),
                                                  ),
                                                ],
                                              ),
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                child: Text(
                                                  copy = data[i].quote,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                      fontFamily: "Kanit"),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                      saveImage(imageBytes);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("Image Save")));
                                    },
                                    child: const Icon(
                                      Icons.file_download_sharp,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        starTap = !starTap;
                                      });
                                    },
                                    child: (starTap == false)
                                        ? const Icon(
                                            Icons.star_border,
                                            color: Colors.blue,
                                            size: 30,
                                          )
                                        : const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 30,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })
                : const Center(
                    child: Text("No Data"),
                  );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
