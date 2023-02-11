import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/controllers/home_controller.dart';
import '../../theme/colores.dart';
import '../../theme/imagenes.dart';

class MenuLateral extends GetResponsiveView {
  // HomeController homeController = Get.find();

  @override
  Widget builder() {
    return GetBuilder<HomeController>(builder: (_) {
      return Container(
          width: 50,
          height: Get.height,
          color: Color.fromARGB(255, 255, 255, 255),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        // screen.isDesktop ? _.vistas.length - 1 : _.vistas.length,
                        _.vistas.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: IconButton(
                              onPressed: () {
                                _.vista.value = index;
                              },
                              icon: Obx(() => Icon(
                                    _.vistas[index]['icono'],
                                    color: _.vista.value == index
                                        ? Color.fromARGB(255, 255, 255, 255)
                                        : Color.fromARGB(255, 255, 255, 255),
                                  ))),
                        ),
                      )),
                ),
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Image.network(
                    "https://d7lju56vlbdri.cloudfront.net/var/ezwebin_site/storage/images/_aliases/img_1col/noticias/solar-orbiter-toma-imagenes-del-sol-como-nunca-antes/9437612-1-esl-MX/Solar-Orbiter-toma-imagenes-del-Sol-como-nunca-antes.jpg",
                    width: 30,
                  ))
            ],
          ));
    });
  }
}

class MenuDrawer extends GetResponsiveView {
  HomeController homeController = Get.find();

  MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget builder() {
    return Stack(
      children: [
        Container(
          width: 300,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          height: Get.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                Imagenes.logo,
                              ),
                              fit: BoxFit.fill),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        height: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: const [
                                  Text(
                                    'Mini Market',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Column(
                        children: List.generate(
                            homeController.vistas.length,
                            // !screen.isDesktop ?
                            // : homeController.vistas.length -1,
                            (index) => ListTile(
                                  selected: homeController.vista.value == index,
                                  selectedColor: Color.fromARGB(255, 0, 0, 0),
                                  textColor: Color.fromARGB(255, 0, 0, 0),
                                  iconColor: Color.fromARGB(255, 0, 0, 0),
                                  leading: Icon(
                                      homeController.vistas[index]['icono']),
                                  title: Text(
                                      homeController.vistas[index]['nombre']),
                                  onTap: () {
                                    Get.back();
                                    homeController.vista.value = index;
                                  },
                                ))),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 10,
            left: 10,
            // child: TituloWidget()
            child: Image.asset(
              Imagenes.logo,
              height: 80,
            ))
      ],
    );
  }
}
