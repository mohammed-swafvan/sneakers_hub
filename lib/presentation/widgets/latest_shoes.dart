import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sneakers_hub/models/sneakers_model.dart';
import 'package:sneakers_hub/presentation/widgets/stagger_tile.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({super.key, required this.shoe});

  final Future<List<SneakersModel>> shoe;

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return FutureBuilder(
      future: shoe,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Erro: ${snapshot.error}"),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("List is empty"),
          );
        }

        return MasonryGridView.count(
          shrinkWrap: true,
          controller: ScrollController(keepScrollOffset: false),
          itemCount: snapshot.data!.length,
          mainAxisSpacing: 16,
          crossAxisSpacing: 20,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final snap = snapshot.data![index];
            return SizedBox(
              height: index % 2 == 0 ? screenHeight * 0.31 : screenHeight * 0.35,
              child: StaggerTile(
                imageUrl: snap.imageUrl[0],
                name: snap.name,
                price: snap.price,
              ),
            );
          },
          crossAxisCount: 2,
        );
      },
    );
  }
}
