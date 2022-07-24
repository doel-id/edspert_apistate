// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:api_state/provider.dart';
import 'package:api_state/views/detail_book_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ListBookPage extends StatefulWidget {
  const ListBookPage({Key? key}) : super(key: key);
  static const String route = "/listbook";

  @override
  State<ListBookPage> createState() => _ListBookPageState();
}

class _ListBookPageState extends State<ListBookPage> {
  int? randomValue;
  @override
  void initState() {
    super.initState();
    // final listbook = Provider.of<DataProvider>(context, listen: false);
    // listbook.getlistdata();

    var rng = Random();
    randomValue = rng.nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("List Book Page"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text("Static : $randomValue"),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<DataProvider>(context, listen: false)
                        .getlistdata();
                  },
                  child: const Text("Refresh"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<DataProvider>(
              builder: (context, value, child) {
                if (value.listbook == null) {
                  // return const Center(child: CircularProgressIndicator());
                  return const Text("Klik refresh untuk melihat data !");
                } else {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: ListView(
                      children: List.generate(
                        value.listbook!.books!.length,
                        (index) => Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailBookPage(
                                          noIs: value
                                              .listbook!.books![index].isbn13,
                                          title: value
                                              .listbook!.books![index].title,
                                        )),
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  value.listbook!.books![index].image!,
                                  height: 180,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          value.listbook!.books![index].title!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        (value.listbook!.books![index]
                                                    .subtitle !=
                                                "")
                                            ? Text(
                                                value.listbook!.books![index]
                                                    .subtitle!,
                                                style: const TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : const SizedBox(),
                                        Text(
                                          value.listbook!.books![index].isbn13!,
                                          style: const TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
