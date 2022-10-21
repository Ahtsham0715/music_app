import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryUi extends StatelessWidget {
  const CategoryUi({super.key});

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text("${args['category_name']}"),
        ),
        GridView.builder(
          padding: const EdgeInsets.all(5.0),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: args['items_list'].length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              onHover: ((ishovering) {
                if (ishovering) {
                  print('hovering');
                } else {
                  print('not hovering');
                }
              }),
              child: Container(
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.blueGrey,
                    image: DecorationImage(
                        image: NetworkImage(
                            args['items_list'][index].toString()))),
              ),
            );
          },
        ),
      ],
    );
  }
}
