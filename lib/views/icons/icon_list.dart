import 'dart:developer' as developer;
import 'dart:io';

import 'package:equilibrium_flutter/models/classes/user_image.dart';
import 'package:equilibrium_flutter/views/subviews/color_inverted.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../subviews/styled_card.dart';

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

  void uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ["jpg", "png", "webp"],
    );

    if (result != null) {
      if (kIsWeb) {
        final file = result.files.single;
        if (file.bytes != null && file.path != null) {
          await connectionHandler.uploadImageWeb(
            file.bytes as List<int>,
            file.path!,
          );
        } else {
          developer.log("Couldn't access file");
        }
      } else {
        String? path = result.files.single.path;
        if (path != null) {
          File file = File(path);
          await connectionHandler.uploadImage(file);
        } else {
          developer.log("Couldn't access file");
        }
      }

      await _refresh();
    } else {
      developer.log("File picker closed without selection");
    }
  }

  void deleteImage(int? id) async {
    await connectionHandler.deleteImage(id);
    await _refresh();
  }

  Future<void> _refresh() async {
    List<UserImage> images = await connectionHandler.getImages();
    setState(() {
      iconsFuture = Future.value(images);
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: uploadImage,
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
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 72),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final icon = icons[index];
          return StyledCard(
            leadingTile: ColorInverted(
              child: Image.network(
                height: 40,
                width: 40,
                "http://${connectionHandler.api?.baseUri ?? ""}/images/${icon.id}",
              ),
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
                                onPressed:
                                    () => Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed:
                                    () => {
                                      Navigator.pop(context, 'Delete'),
                                      deleteImage(icon.id),
                                    },
                                child: const Text(
                                  'Delete',
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
      ),
    );
  }
}
