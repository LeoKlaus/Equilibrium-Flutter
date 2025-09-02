import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../subviews/tappable_card.dart';

class IconList extends StatefulWidget {
  const IconList({super.key});

  @override
  State<IconList> createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  final HubConnectionHandler connectionHandler =
      GetIt.instance<HubConnectionHandler>();

  late Future<List<UserImage>> iconsFuture;

  _IconListState();

  @override
  void initState() {
    super.initState();
    iconsFuture = connectionHandler.getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Icons'),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder<List<UserImage>>(
          future: iconsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final icons = snapshot.data!;
              return buildIcons(icons);
            } else if (snapshot.hasError) {
              return Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  spacing: 20,
                  children: [
                    Text("Error: ${snapshot.error}"),
                    ElevatedButton(
                      onPressed: () {
                        context.go("/connect");
                      },
                      child: Text("Check connected hub."),
                    ),
                  ],
                ),
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildIcons(List<UserImage> icons) {
    return ListView.builder(
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];
        return StyledCard(
          leadingTile: Image.network(
            height: 40,
            width: 40,
            "http://${connectionHandler.api?.baseUri ?? ""}/images/${icon.id}",
          ),
          title: icon.filename,
          subTitle: icon.path,
          trailingTile: PopupMenuButton(
            onSelected: (selection) {
              switch (selection) {
                case 1:
                  showDialog<String>(
                    context: context,
                    builder:
                        (BuildContext context) => AlertDialog(
                          title: Text('Delete ${icon.filename}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                connectionHandler.deleteImage(icon.id);
                                iconsFuture = connectionHandler.getImages();
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                  );
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 1,
                    // row with 2 children
                    child: Row(
                      children: [
                        const Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 10),
                        const Text(
                          "Delete",
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
          ),
        );
      },
    );
  }
}
