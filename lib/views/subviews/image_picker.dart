import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/hub_connection_handler.dart';
import '../../models/classes/user_image.dart';

class ImagePicker extends StatefulWidget {

  final UserImage? initialSelection;
  final Function(UserImage?) updateSelection;

  const ImagePicker({super.key, required this.updateSelection, this.initialSelection});

  @override
  State<StatefulWidget> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {

  final HubConnectionHandler connectionHandler =
  GetIt.instance<HubConnectionHandler>();

  late Future<List<UserImage>> iconsFuture;

  @override
  void initState() {
    super.initState();
    iconsFuture = connectionHandler.getImages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserImage>>(
      future: iconsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile(
            title: Text("loading images..."),
            leading: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          final icons = snapshot.data!;
          return DropdownMenu<UserImage?>(
            width: double.infinity,
            initialSelection: widget.initialSelection,
            requestFocusOnTap: false,
            label: const Text('Select image'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: icons.map((icon) {
              return icon.toDropDownMenuEntry(connectionHandler.api?.baseUri);
            }).toList()+
                [DropdownMenuEntry<UserImage?>(value: null, label: "None")],
          );
        } else if (snapshot.hasError) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              spacing: 20,
              children: [
                Text("Error loading images: ${snapshot.error}"),
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
          return DropdownMenu<UserImage?>(
            width: double.infinity,
            initialSelection: widget.initialSelection,
            requestFocusOnTap: false,
            label: const Text('Image'),
            onSelected: widget.updateSelection,
            dropdownMenuEntries: [],
          );
        }
      },
    );
  }
}
