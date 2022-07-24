// ignore_for_file: depend_on_referenced_packages

import 'package:api_state/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailBookPage extends StatefulWidget {
  final String? noIs;
  final String? title;
  const DetailBookPage({
    Key? key,
    @required this.noIs,
    @required this.title,
  }) : super(key: key);

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false)
        .getDetailBook(widget.noIs!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        centerTitle: true,
      ),
      body: Consumer<DataProvider>(
        builder: (context, value, child) {
          if (value.detailBook == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    Image.network(
                      value.detailBook!.image!,
                      scale: 1.5,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value.detailBook!.title!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              value.detailBook!.publisher!,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Text(
                              "Author : ${value.detailBook!.authors!}",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${value.detailBook!.language!} - ${value.detailBook!.rating!} stars ",
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              value.detailBook?.subtitle ?? "No Subtittle",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              value.detailBook!.price!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        launchUrlString(value.detailBook!.url!);
                      },
                      child: const Text(
                        "BUY",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.detailBook!.desc!,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
