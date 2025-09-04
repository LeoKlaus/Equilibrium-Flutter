import 'package:equilibrium_flutter/models/enums/bluetooth_command_type.dart';
import 'package:flutter/material.dart';

enum BluetoothCommand {
  // Regular keys
  escape,
  enter,
  up,
  down,
  left,
  right,
  other,
  // Media keys
  play,
  pause,
  playPause,
  fastForward,
  rewind,
  nextTrack,
  previousTrack,
  stop,
  menu,
  volumeUp,
  volumeDown,
  mute,
  power,
  menuPick,
  search,
  home;

  String? rawValue() {
    switch (this) {
      case BluetoothCommand.escape:
        return "KEY_ESC";
      case BluetoothCommand.enter:
        return "KEY_ENTER";
      case BluetoothCommand.up:
        return "KEY_UP";
      case BluetoothCommand.down:
        return "KEY_DOWN";
      case BluetoothCommand.left:
        return "KEY_LEFT";
      case BluetoothCommand.right:
        return "KEY_RIGHT";
      case BluetoothCommand.other:
        return null;
      case BluetoothCommand.play:
        return "KEY_PLAY";
      case BluetoothCommand.pause:
        return "KEY_PAUSE";
      case BluetoothCommand.playPause:
        return "KEY_PLAY_PAUSE";
      case BluetoothCommand.fastForward:
        return "KEY_FAST_FORWARD";
      case BluetoothCommand.rewind:
        return "KEY_REWIND";
      case BluetoothCommand.nextTrack:
        return "KEY_NEXT_TRACK";
      case BluetoothCommand.previousTrack:
        return "KEY_PREVIOUS_TRACK";
      case BluetoothCommand.stop:
        return "KEY_STOP";
      case BluetoothCommand.menu:
        return "KEY_MENU";
      case BluetoothCommand.volumeUp:
        return "KEY_VOLUME_UP";
      case BluetoothCommand.volumeDown:
        return "KEY_VOLUME_DOWN";
      case BluetoothCommand.mute:
        return "KEY_MUTE";
      case BluetoothCommand.power:
        return "KEY_POWER";
      case BluetoothCommand.menuPick:
        return "KEY_MENU_PICK";
      case BluetoothCommand.search:
        return "KEY_AC_SEARCH";
      case BluetoothCommand.home:
        return "KEY_AC_HOME";
    }
  }

  static List<DropdownMenuEntry<BluetoothCommand>> dropDownEntries(BluetoothCommandType type) {
    switch (type) {
      case BluetoothCommandType.regularKey:
        return [
          DropdownMenuEntry(value: BluetoothCommand.escape, label: "Escape"),
          DropdownMenuEntry(value: BluetoothCommand.enter, label: "Enter"),
          DropdownMenuEntry(value: BluetoothCommand.up, label: "Up"),
          DropdownMenuEntry(value: BluetoothCommand.down, label: "Down"),
          DropdownMenuEntry(value: BluetoothCommand.left, label: "Left"),
          DropdownMenuEntry(value: BluetoothCommand.right, label: "Right"),
          DropdownMenuEntry(value: BluetoothCommand.other, label: "Other"),
        ];
      case BluetoothCommandType.mediaKey:
        return [
          DropdownMenuEntry(value: BluetoothCommand.play, label: "Play"),
          DropdownMenuEntry(value: BluetoothCommand.pause, label: "Pause"),
          DropdownMenuEntry(value: BluetoothCommand.playPause, label: "Play/Pause"),
          DropdownMenuEntry(value: BluetoothCommand.fastForward, label: "Fast forward"),
          DropdownMenuEntry(value: BluetoothCommand.rewind, label: "Rewind"),
          DropdownMenuEntry(value: BluetoothCommand.nextTrack, label: "Next track"),
          DropdownMenuEntry(value: BluetoothCommand.previousTrack, label: "Previous track"),
          DropdownMenuEntry(value: BluetoothCommand.stop, label: "Stop"),
          DropdownMenuEntry(value: BluetoothCommand.menu, label: "Menu"),
          DropdownMenuEntry(value: BluetoothCommand.volumeUp, label: "Volume up"),
          DropdownMenuEntry(value: BluetoothCommand.volumeDown, label: "Volume down"),
          DropdownMenuEntry(value: BluetoothCommand.mute, label: "Mute"),
          DropdownMenuEntry(value: BluetoothCommand.power, label: "Power"),
          DropdownMenuEntry(value: BluetoothCommand.menuPick, label: "Menu Select"),
          DropdownMenuEntry(value: BluetoothCommand.search, label: "Search"),
          DropdownMenuEntry(value: BluetoothCommand.home, label: "Home"),
        ];
    }
  }
}