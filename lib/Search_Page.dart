import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              right: 20,
              left: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/icons/arrow.png"),
                          fit: BoxFit.cover,
                        ),
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: searchController,

                      decoration: InputDecoration(hintText: "Search.."),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/icons/search2.png"),
                          fit: BoxFit.cover,
                        ),
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
