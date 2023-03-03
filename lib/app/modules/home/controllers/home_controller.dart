import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/models/ongkir_model.dart';

class HomeController extends GetxController {
  RxString idProvAsal = "0".obs;
  RxString idProvTujuan = "0".obs;
  RxString idKotaAsal = "0".obs;
  RxString idKotaTujuan = "0".obs;
  RxString kodeKurir = "".obs;

  TextEditingController beratC = TextEditingController();

  List<Ongkir> ongkosKirim = [];

  void cekOngkir() async {
    if (idProvAsal != "0" &&
        idProvTujuan != "0" &&
        idKotaAsal != "0" &&
        idKotaTujuan != "0" &&
        beratC.text != "" &&
        kodeKurir != "") {
      try {
        var response = await http.post(
          Uri.parse("https://api.rajaongkir.com/starter/cost"),
          headers: {"key": "3471682cc24083416fe2d74511d51840"},
          body: {
            "origin": idKotaAsal.value,
            "destination": idKotaTujuan.value,
            "weight": beratC.text,
            "courier": kodeKurir.value,
          },
        );
        List ongkir = json.decode(response.body)["rajaongkir"]["results"][0]
            ["costs"] as List;
        ongkosKirim = Ongkir.fromJsonList(ongkir);
        Get.defaultDialog(
          title: "Ongkos Kirim",
          content: SizedBox(
            width: 999,
            height: 300,
            child: ListView.builder(
              itemCount: ongkosKirim.length,
              itemBuilder: (context, index) => ListTile(
                title: Text("${ongkosKirim[index].service}"),
                subtitle: Text("Rp ${ongkosKirim[index].cost![0].value}"),
              ),
            ),
          ),
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Error",
          middleText: "Tidak dapat mengecek ongkir",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Data tidak lengkap",
      );
    }
  }
}
