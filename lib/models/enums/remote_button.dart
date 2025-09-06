import 'package:equilibrium_flutter/models/enums/command_group_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

enum RemoteButton {
  // Power
  @JsonValue("power_toggle")
  powerToggle,
  @JsonValue("power_off")
  powerOff,
  @JsonValue("power_on")
  powerOn,
  // Volume
  @JsonValue("volume_up")
  volumeUp,
  @JsonValue("volume_down")
  volumeDown,
  @JsonValue("mute")
  mute,
  // Navigation
  @JsonValue("direction_up")
  directionUp,
  @JsonValue("direction_down")
  directionDown,
  @JsonValue("direction_left")
  directionLeft,
  @JsonValue("direction_right")
  directionRight,
  @JsonValue("select")
  select,
  @JsonValue("guide")
  guide,
  @JsonValue("info")
  info,
  @JsonValue("back")
  back,
  @JsonValue("menu")
  menu,
  @JsonValue("home")
  home,
  @JsonValue("exit")
  exit,
  // Transport
  @JsonValue("play")
  play,
  @JsonValue("pause")
  pause,
  @JsonValue("playpause")
  playpause,
  @JsonValue("stop")
  stop,
  @JsonValue("fast_forward")
  fastForward,
  @JsonValue("rewind")
  rewind,
  @JsonValue("next_track")
  nextTrack,
  @JsonValue("previous_track")
  previousTrack,
  @JsonValue("record")
  record,
  @JsonValue("channel_up")
  channelUp,
  @JsonValue("channel_down")
  channelDown,
  // Colored buttons
  @JsonValue("green")
  green,
  @JsonValue("red")
  red,
  @JsonValue("blue")
  blue,
  @JsonValue("yellow")
  yellow,
  // Numbers)
  @JsonValue("number_zero")
  numberZero,
  @JsonValue("number_one")
  numberOne,
  @JsonValue("number_two")
  numberTwo,
  @JsonValue("number_three")
  numberThree,
  @JsonValue("number_four")
  numberFour,
  @JsonValue("number_five")
  numberFive,
  @JsonValue("number_six")
  numberSix,
  @JsonValue("number_seven")
  numberSeven,
  @JsonValue("number_eight")
  numberEight,
  @JsonValue("number_nine")
  numberNine,
  // Integration
  @JsonValue("brightness_up")
  brightnessUp,
  @JsonValue("brightness_down")
  brightnessDown,
  @JsonValue("turn_on")
  turnOn,
  @JsonValue("turn_off")
  turnOff,
  // Fallback
  @JsonValue("other")
  other;

  IconData get icon {
    switch (this) {
      case RemoteButton.powerToggle:
        return Icons.power_settings_new;
      case RemoteButton.powerOff:
        return Icons.power_settings_new;
      case RemoteButton.powerOn:
        return Icons.power_settings_new;
      case RemoteButton.volumeUp:
        return Icons.volume_up;
      case RemoteButton.volumeDown:
        return Icons.volume_down;
      case RemoteButton.mute:
        return Icons.volume_mute;
      case RemoteButton.directionUp:
        return Icons.arrow_drop_up;
      case RemoteButton.directionDown:
        return Icons.arrow_drop_down;
      case RemoteButton.directionLeft:
        return Icons.arrow_left;
      case RemoteButton.directionRight:
        return Icons.arrow_right;
      case RemoteButton.select:
        return Icons.radio_button_checked;
      case RemoteButton.guide:
        return Icons.explore;
      case RemoteButton.info:
        return Icons.info_outline;
      case RemoteButton.back:
        return Icons.arrow_back;
      case RemoteButton.menu:
        return Icons.menu;
      case RemoteButton.home:
        return Icons.home_outlined;
      case RemoteButton.exit:
        return Icons.exit_to_app;
      case RemoteButton.play:
        return Icons.play_arrow;
      case RemoteButton.pause:
        return Icons.pause;
      case RemoteButton.playpause:
        return Icons.play_arrow_outlined;
      case RemoteButton.stop:
        return Icons.stop;
      case RemoteButton.fastForward:
        return Icons.fast_forward;
      case RemoteButton.rewind:
        return Icons.fast_rewind;
      case RemoteButton.nextTrack:
        return Icons.skip_next;
      case RemoteButton.previousTrack:
        return Icons.skip_previous;
      case RemoteButton.record:
        return Icons.fiber_manual_record;
      case RemoteButton.channelUp:
        return Icons.upload;
      case RemoteButton.channelDown:
        return Icons.download;
      case RemoteButton.green:
        return Icons.rectangle_rounded;
      case RemoteButton.red:
        return Icons.rectangle_rounded;
      case RemoteButton.blue:
        return Icons.rectangle_rounded;
      case RemoteButton.yellow:
        return Icons.rectangle_rounded;
      case RemoteButton.numberZero:
        return IconData(0x0030, fontFamily: "robotoCondensed");
      case RemoteButton.numberOne:
        return IconData(0x0031, fontFamily: "robotoCondensed");
      case RemoteButton.numberTwo:
        return IconData(0x0032, fontFamily: "robotoCondensed");
      case RemoteButton.numberThree:
        return IconData(0x0033, fontFamily: "robotoCondensed");
      case RemoteButton.numberFour:
        return IconData(0x0034, fontFamily: "robotoCondensed");
      case RemoteButton.numberFive:
        return IconData(0x0035, fontFamily: "robotoCondensed");
      case RemoteButton.numberSix:
        return IconData(0x0036, fontFamily: 'robotoCondensed');
      case RemoteButton.numberSeven:
        return IconData(0x0037, fontFamily: "robotoCondensed");
      case RemoteButton.numberEight:
        return IconData(0x0038, fontFamily: "robotoCondensed");
      case RemoteButton.numberNine:
        return IconData(0x0039, fontFamily: "robotoCondensed");
      case RemoteButton.brightnessUp:
        return Icons.brightness_high;
      case RemoteButton.brightnessDown:
        return Icons.brightness_low;
      case RemoteButton.turnOn:
        return Icons.power;
      case RemoteButton.turnOff:
        return Icons.power_off;
      case RemoteButton.other:
        return Icons.more_horiz;
    }
  }

  static List<DropdownMenuEntry<RemoteButton>> dropDownEntries(
      CommandGroupType type,
      ) {
    switch (type) {
      case CommandGroupType.power:
        return [
          DropdownMenuEntry(
            value: RemoteButton.powerToggle,
            label: "Power toggle",
            leadingIcon: Icon(RemoteButton.powerToggle.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.powerOn,
            label: "Power on",
            leadingIcon: Icon(RemoteButton.powerOn.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.powerOff,
            label: "Power off",
            leadingIcon: Icon(RemoteButton.powerOff.icon),
          ),
        ];
      case CommandGroupType.volume:
        return [
          DropdownMenuEntry(
            value: RemoteButton.volumeUp,
            label: "Volume up",
            leadingIcon: Icon(RemoteButton.volumeUp.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.volumeDown,
            label: "Volume down",
            leadingIcon: Icon(RemoteButton.volumeDown.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.mute,
            label: "Mute",
            leadingIcon: Icon(RemoteButton.mute.icon),
          ),
        ];
      case CommandGroupType.navigation:
        return [
          DropdownMenuEntry(
            value: RemoteButton.directionUp,
            label: "Up",
            leadingIcon: Icon(RemoteButton.directionUp.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionDown,
            label: "Down",
            leadingIcon: Icon(RemoteButton.directionDown.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionLeft,
            label: "Left",
            leadingIcon: Icon(RemoteButton.directionLeft.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionRight,
            label: "Right",
            leadingIcon: Icon(RemoteButton.directionRight.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.select,
            label: "Select",
            leadingIcon: Icon(RemoteButton.select.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.back,
            label: "Back",
            leadingIcon: Icon(RemoteButton.back.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.menu,
            label: "Menu",
            leadingIcon: Icon(RemoteButton.menu.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.exit,
            label: "Exit",
            leadingIcon: Icon(RemoteButton.exit.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.guide,
            label: "Guide",
            leadingIcon: Icon(RemoteButton.guide.icon),
          ),
        ];
      case CommandGroupType.transport:
        return [
          DropdownMenuEntry(
            value: RemoteButton.playpause,
            label: "Play/Pause",
            leadingIcon: Icon(RemoteButton.playpause.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.play,
            label: "Play",
            leadingIcon: Icon(RemoteButton.play.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.pause,
            label: "Pause",
            leadingIcon: Icon(RemoteButton.pause.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.stop,
            label: "Stop",
            leadingIcon: Icon(RemoteButton.stop.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.fastForward,
            label: "Fast forward",
            leadingIcon: Icon(RemoteButton.fastForward.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.rewind,
            label: "Rewind",
            leadingIcon: Icon(RemoteButton.rewind.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.nextTrack,
            label: "Next track",
            leadingIcon: Icon(RemoteButton.nextTrack.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.previousTrack,
            label: "Previous track",
            leadingIcon: Icon(RemoteButton.previousTrack.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.record,
            label: "Record",
            leadingIcon: Icon(RemoteButton.record.icon),
          ),
        ];
      case CommandGroupType.channel:
        return [
          DropdownMenuEntry(
            value: RemoteButton.channelUp,
            label: "Channel up",
            leadingIcon: Icon(RemoteButton.channelUp.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.channelDown,
            label: "Channel down",
            leadingIcon: Icon(RemoteButton.channelDown.icon),
          ),
        ];
      case CommandGroupType.numeric:
        return [
          DropdownMenuEntry(
            value: RemoteButton.numberZero,
            label: "0",
            leadingIcon: Icon(RemoteButton.numberZero.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberOne,
            label: "1",
            leadingIcon: Icon(RemoteButton.numberOne.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberTwo,
            label: "2",
            leadingIcon: Icon(RemoteButton.numberTwo.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberThree,
            label: "3",
            leadingIcon: Icon(RemoteButton.numberThree.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberFour,
            label: "4",
            leadingIcon: Icon(RemoteButton.numberFour.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberFive,
            label: "5",
            leadingIcon: Icon(RemoteButton.numberFive.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberSix,
            label: "6",
            leadingIcon: Icon(RemoteButton.numberSix.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberSeven,
            label: "7",
            leadingIcon: Icon(RemoteButton.numberSeven.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberEight,
            label: "8",
            leadingIcon: Icon(RemoteButton.numberEight.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberNine,
            label: "9",
            leadingIcon: Icon(RemoteButton.numberNine.icon),
          ),
        ];
      case CommandGroupType.input:
        return [
          DropdownMenuEntry(
            value: RemoteButton.other,
            label: "Other",
            leadingIcon: Icon(RemoteButton.other.icon),
          ),
        ];
      case CommandGroupType.coloredButtons:
        return [
          DropdownMenuEntry(
            value: RemoteButton.green,
            label: "Green",
            leadingIcon: Icon(RemoteButton.green.icon, color: Colors.green),
          ),
          DropdownMenuEntry(
            value: RemoteButton.red,
            label: "Red",
            leadingIcon: Icon(RemoteButton.red.icon, color: Colors.red),
          ),
          DropdownMenuEntry(
            value: RemoteButton.blue,
            label: "Blue",
            leadingIcon: Icon(RemoteButton.blue.icon, color: Colors.blue),
          ),
          DropdownMenuEntry(
            value: RemoteButton.yellow,
            label: "Yellow",
            leadingIcon: Icon(RemoteButton.yellow.icon, color: Colors.yellow),
          ),
        ];
      case CommandGroupType.other:
        return [
          DropdownMenuEntry(
            value: RemoteButton.brightnessUp,
            label: "Brightness up",
            leadingIcon: Icon(RemoteButton.brightnessUp.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.brightnessDown,
            label: "Brightness down",
            leadingIcon: Icon(RemoteButton.brightnessDown.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.turnOn,
            label: "Turn on",
            leadingIcon: Icon(RemoteButton.turnOn.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.turnOff,
            label: "Turn off",
            leadingIcon: Icon(RemoteButton.turnOff.icon),
          ),
          DropdownMenuEntry(
            value: RemoteButton.other,
            label: "Other",
            leadingIcon: Icon(RemoteButton.other.icon),
          ),
        ];
    }
  }
}