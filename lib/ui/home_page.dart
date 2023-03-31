import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import '../data/models/currency_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getDataFromApi() async {
    var response = await Dio().get('https://nbu.uz/en/exchange-rates/json/');
    List currencies = response.data.map((current_currency) {
      return Currency.fromJson(current_currency);
    }).toList();
    return currencies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: getDataFromApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData) {
              List data = snapshot.data!;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemBuilder: (context, index) => SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    color: const Color(0xFF18181b),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountryFlags.flag(
                            data[index].code.substring(0, 2),
                            width: 90,
                            height: 50,
                          ),
                          Text(
                            data[index].title,
                            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.white),
                          ),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${data[index].cb_price}',
                                  style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.white),
                                ),
                               const TextSpan(
                                  text: '  UZS',
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center();
            }
            return const Center();
          },
        ),
      ),
    );
  }
}
