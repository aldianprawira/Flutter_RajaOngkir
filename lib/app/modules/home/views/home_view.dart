import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../controllers/home_controller.dart';
import '../../../data/models/province_model.dart';
import '../../../data/models/city_model.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Raja Ongkir'),
          centerTitle: true,
          backgroundColor: const Color(0xff9B59BB),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(30),
          children: [
            DropdownSearch<Province>(
              validator: (value) => value == null ? 'wajib diisi' : null,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "3471682cc24083416fe2d74511d51840"},
                );
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.province}"),
                ),
              ),
              onChanged: (value) =>
                  controller.idProvAsal.value = value?.provinceId ?? "0",
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Asal",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownSearch<City>(
              validator: (value) => value == null ? 'wajib diisi' : null,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.idProvAsal}",
                  queryParameters: {"key": "3471682cc24083416fe2d74511d51840"},
                );
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                ),
              ),
              onChanged: (value) =>
                  controller.idKotaAsal.value = value?.cityId ?? "0",
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota/Kabupaten Asal",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownSearch<Province>(
              validator: (value) => value == null ? 'wajib diisi' : null,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/province",
                  queryParameters: {"key": "3471682cc24083416fe2d74511d51840"},
                );
                return Province.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.province}"),
                ),
              ),
              onChanged: (value) =>
                  controller.idProvTujuan.value = value?.provinceId ?? "0",
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Provinsi Tujuan",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownSearch<City>(
              validator: (value) => value == null ? 'wajib diisi' : null,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              asyncItems: (text) async {
                var response = await Dio().get(
                  "https://api.rajaongkir.com/starter/city?province=${controller.idProvTujuan}",
                  queryParameters: {"key": "3471682cc24083416fe2d74511d51840"},
                );
                return City.fromJsonList(
                    response.data["rajaongkir"]["results"]);
              },
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item.type} ${item.cityName}"),
                ),
              ),
              onChanged: (value) =>
                  controller.idKotaTujuan.value = value?.cityId ?? "0",
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Kota/Kabupaten Tujuan",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: controller.beratC,
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 15,
                ),
                labelText: "Berat Paket (gram)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
            const SizedBox(height: 30),
            DropdownSearch<Map<String, dynamic>>(
              validator: (value) => value == null ? 'wajib diisi' : null,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              items: const [
                {
                  "code": "jne",
                  "name": "JNE",
                },
                {
                  "code": "pos",
                  "name": "POS INDONESIA",
                },
                {
                  "code": "tiki",
                  "name": "TIKI",
                },
              ],
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => ListTile(
                  title: Text("${item['name']}"),
                ),
              ),
              dropdownBuilder: (context, selectedItem) =>
                  Text("${selectedItem?['name'] ?? ''}"),
              onChanged: (value) =>
                  controller.kodeKurir.value = value?["code"] ?? "",
              clearButtonProps: const ClearButtonProps(
                isVisible: true,
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Pilih Kurir",
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => controller.cekOngkir(),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff9B59BB),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  )),
              child: const Text(
                "Cek Ongkir",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
