import 'package:flutter/material.dart';

class CategoriesUi extends StatelessWidget {
  const CategoriesUi({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Text("Title 1"),
        GridView.builder(
          padding: const EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 10,
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
                ),
                child: Text("index: $index"),
              ),
            );
          },
        ),
        const Text("Title 2"),
        GridView.builder(
          padding: const EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.blue,
              child: Text("index: $index"),
            );
          },
        ),
        const Text("Title 3"),
        GridView.builder(
          padding: const EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.blue,
              child: Text("index: $index"),
            );
          },
        ),
        const Text("Title 4"),
        GridView.builder(
          padding: const EdgeInsets.all(10.0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.blue,
              child: Text("index: $index"),
            );
          },
        )
      ],
    );
  }
}
