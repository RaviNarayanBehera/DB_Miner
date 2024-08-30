import 'package:db_miner/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'dart:ui' as ui;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_extend/share_extend.dart';

import '../utils/globals.dart';

GlobalKey imgKey = GlobalKey();

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff605f),
        centerTitle: true,
        title: const Text(
          'Detail Page',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RepaintBoundary(
                    key: imgKey,
                    child: Container(
                      height: 550,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: quotesController.backgroundImage.value.isEmpty
                              ? null
                              : DecorationImage(
                                  image: AssetImage(
                                      quotesController.backgroundImage.value),
                                  fit: BoxFit.fill,
                                ),
                          color: Colors.red.shade100),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            quotesController.quotes[selectedIndex].quote,
                            style: TextStyle(
                                color: quotesController.selectColor.value,
                                fontFamily:
                                    quotesController.selectedFontFamily.value,
                                fontSize: 30),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () async {
                          RenderRepaintBoundary boundary =
                              imgKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary;

                          ui.Image image = await boundary.toImage();

                          ByteData? byteData = await image.toByteData(
                              format: ui.ImageByteFormat.png);

                          Uint8List img = byteData!.buffer.asUint8List();

                          ImageGallerySaver.saveImage(img);
                        },
                        icon: const Icon(
                          Icons.save_alt_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          RenderRepaintBoundary boundary =
                              imgKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary;

                          ui.Image image = await boundary.toImage();

                          ByteData? byteData = await image.toByteData(
                              format: ui.ImageByteFormat.png);

                          Uint8List img = byteData!.buffer.asUint8List();

                          final path = await getApplicationDocumentsDirectory();

                          File file = File("${path.path}/img.png");
                          file.writeAsBytes(img);

                          ShareExtend.share(file.path, "image");
                        },
                        icon: const Icon(
                          Icons.share_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          RenderRepaintBoundary boundary =
                              imgKey.currentContext!.findRenderObject()
                                  as RenderRepaintBoundary;

                          ui.Image image = await boundary.toImage();

                          ByteData? byteData = await image.toByteData(
                              format: ui.ImageByteFormat.png);

                          Uint8List img = byteData!.buffer.asUint8List();

                          final path = await getApplicationDocumentsDirectory();

                          File file = File("${path.path}/img.png");
                          file.writeAsBytes(img);

                          ShareExtend.share(file.path, "image");
                          int location = WallpaperManager
                              .BOTH_SCREEN; //can be Home/Lock Screen
                          bool result =
                              await WallpaperManager.setWallpaperFromFile(
                                  file.path, location); //provide image path
                        },
                        icon: const Icon(
                          Icons.wallpaper_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Font Color',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 24),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              colorList.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  quotesController
                                      .updateColor(colorList[index]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorList[index],
                                    border: Border.all(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Font Style',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              fontFamily.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  quotesController
                                      .updateFontFamily(fontFamily[index]);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: Text(
                                        '${fontFamily[index]}',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: '${fontFamily[index]}'),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'BackGround',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 24),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                              themeList.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  quotesController
                                      .updateBackgroundImage(themeList[index]);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(5),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          image: AssetImage(themeList[index]),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
