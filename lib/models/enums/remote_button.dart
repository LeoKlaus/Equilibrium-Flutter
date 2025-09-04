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

  static Widget icon(RemoteButton button) {
    switch (button) {
      case RemoteButton.powerToggle:
        return Icon(Icons.power_settings_new);
      case RemoteButton.powerOff:
        return Icon(Icons.power_settings_new);
      case RemoteButton.powerOn:
        return Icon(Icons.power_settings_new);
      case RemoteButton.volumeUp:
        return Icon(Icons.volume_up);
      case RemoteButton.volumeDown:
        return Icon(Icons.volume_down);
      case RemoteButton.mute:
        return Icon(Icons.volume_mute);
      case RemoteButton.directionUp:
        return Icon(Icons.arrow_drop_up);
      case RemoteButton.directionDown:
        return Icon(Icons.arrow_drop_down);
      case RemoteButton.directionLeft:
        return Icon(Icons.arrow_left);
      case RemoteButton.directionRight:
        return Icon(Icons.arrow_right);
      case RemoteButton.select:
        return Icon(Icons.radio_button_checked);
      case RemoteButton.guide:
        return Icon(Icons.explore);
      case RemoteButton.info:
        return Icon(Icons.info_outline);
      case RemoteButton.back:
        return Icon(Icons.arrow_back);
      case RemoteButton.menu:
        return Icon(Icons.menu);
      case RemoteButton.home:
        return Icon(Icons.home_outlined);
      case RemoteButton.exit:
        return Icon(Icons.exit_to_app);
      case RemoteButton.play:
        return Icon(Icons.play_arrow);
      case RemoteButton.pause:
        return Icon(Icons.pause);
      case RemoteButton.playpause:
        return Icon(Icons.play_arrow_outlined);
      case RemoteButton.stop:
        return Icon(Icons.stop);
      case RemoteButton.fastForward:
        return Icon(Icons.fast_forward);
      case RemoteButton.rewind:
        return Icon(Icons.fast_rewind);
      case RemoteButton.nextTrack:
        return Icon(Icons.skip_next);
      case RemoteButton.previousTrack:
        return Icon(Icons.skip_previous);
      case RemoteButton.record:
        return Icon(Icons.fiber_manual_record);
      case RemoteButton.channelUp:
        return Icon(Icons.upload);
      case RemoteButton.channelDown:
        return Icon(Icons.download);
      case RemoteButton.green:
        return Icon(Icons.rectangle_rounded, color: Colors.green);
      case RemoteButton.red:
        return Icon(Icons.rectangle_rounded, color: Colors.red);
      case RemoteButton.blue:
        return Icon(Icons.rectangle_rounded, color: Colors.blue);
      case RemoteButton.yellow:
        return Icon(Icons.rectangle_rounded, color: Colors.yellow);
      case RemoteButton.numberZero:
        return Text("0");
      case RemoteButton.numberOne:
        return Text("1");
      case RemoteButton.numberTwo:
        return Text("2");
      case RemoteButton.numberThree:
        return Text("3");
      case RemoteButton.numberFour:
        return Text("4");
      case RemoteButton.numberFive:
        return Text("5");
      case RemoteButton.numberSix:
        return Text("6");
      case RemoteButton.numberSeven:
        return Text("7");
      case RemoteButton.numberEight:
        return Text("8");
      case RemoteButton.numberNine:
        return Text("9");
      case RemoteButton.brightnessUp:
        return Icon(Icons.brightness_high);
      case RemoteButton.brightnessDown:
        return Icon(Icons.brightness_low);
      case RemoteButton.turnOn:
        return Icon(Icons.power);
      case RemoteButton.turnOff:
        return Icon(Icons.power_off);
      case RemoteButton.other:
        return Icon(Icons.more_horiz);
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
            leadingIcon: RemoteButton.icon(RemoteButton.powerToggle),
          ),
          DropdownMenuEntry(
            value: RemoteButton.powerOn,
            label: "Power on",
            leadingIcon: RemoteButton.icon(RemoteButton.powerOn),
          ),
          DropdownMenuEntry(
            value: RemoteButton.powerOff,
            label: "Power off",
            leadingIcon: RemoteButton.icon(RemoteButton.powerOff),
          ),
        ];
      case CommandGroupType.volume:
        return [
          DropdownMenuEntry(
            value: RemoteButton.volumeUp,
            label: "Volume up",
            leadingIcon: RemoteButton.icon(RemoteButton.volumeUp),
          ),
          DropdownMenuEntry(
            value: RemoteButton.volumeDown,
            label: "Volume down",
            leadingIcon: RemoteButton.icon(RemoteButton.volumeDown),
          ),
          DropdownMenuEntry(
            value: RemoteButton.mute,
            label: "Mute",
            leadingIcon: RemoteButton.icon(RemoteButton.mute),
          ),
        ];
      case CommandGroupType.navigation:
        return [
          DropdownMenuEntry(
            value: RemoteButton.directionUp,
            label: "Up",
            leadingIcon: RemoteButton.icon(RemoteButton.directionUp),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionDown,
            label: "Down",
            leadingIcon: RemoteButton.icon(RemoteButton.directionDown),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionLeft,
            label: "Left",
            leadingIcon: RemoteButton.icon(RemoteButton.directionLeft),
          ),
          DropdownMenuEntry(
            value: RemoteButton.directionRight,
            label: "Right",
            leadingIcon: RemoteButton.icon(RemoteButton.directionRight),
          ),
          DropdownMenuEntry(
            value: RemoteButton.select,
            label: "Select",
            leadingIcon: RemoteButton.icon(RemoteButton.select),
          ),
          DropdownMenuEntry(
            value: RemoteButton.back,
            label: "Back",
            leadingIcon: RemoteButton.icon(RemoteButton.back),
          ),
          DropdownMenuEntry(
            value: RemoteButton.menu,
            label: "Menu",
            leadingIcon: RemoteButton.icon(RemoteButton.menu),
          ),
          DropdownMenuEntry(
            value: RemoteButton.exit,
            label: "Exit",
            leadingIcon: RemoteButton.icon(RemoteButton.exit),
          ),
          DropdownMenuEntry(
            value: RemoteButton.guide,
            label: "Guide",
            leadingIcon: RemoteButton.icon(RemoteButton.guide),
          ),
        ];
      case CommandGroupType.transport:
        return [
          DropdownMenuEntry(
            value: RemoteButton.playpause,
            label: "Play/Pause",
            leadingIcon: RemoteButton.icon(RemoteButton.playpause),
          ),
          DropdownMenuEntry(
            value: RemoteButton.play,
            label: "Play",
            leadingIcon: RemoteButton.icon(RemoteButton.play),
          ),
          DropdownMenuEntry(
            value: RemoteButton.pause,
            label: "Pause",
            leadingIcon: RemoteButton.icon(RemoteButton.pause),
          ),
          DropdownMenuEntry(
            value: RemoteButton.stop,
            label: "Stop",
            leadingIcon: RemoteButton.icon(RemoteButton.stop),
          ),
          DropdownMenuEntry(
            value: RemoteButton.fastForward,
            label: "Fast forward",
            leadingIcon: RemoteButton.icon(RemoteButton.fastForward),
          ),
          DropdownMenuEntry(
            value: RemoteButton.rewind,
            label: "Rewind",
            leadingIcon: RemoteButton.icon(RemoteButton.rewind),
          ),
          DropdownMenuEntry(
            value: RemoteButton.nextTrack,
            label: "Next track",
            leadingIcon: RemoteButton.icon(RemoteButton.nextTrack),
          ),
          DropdownMenuEntry(
            value: RemoteButton.previousTrack,
            label: "Previous track",
            leadingIcon: RemoteButton.icon(RemoteButton.previousTrack),
          ),
          DropdownMenuEntry(
            value: RemoteButton.record,
            label: "Record",
            leadingIcon: RemoteButton.icon(RemoteButton.record),
          ),
        ];
      case CommandGroupType.channel:
        return [
          DropdownMenuEntry(
            value: RemoteButton.channelUp,
            label: "Channel up",
            leadingIcon: RemoteButton.icon(RemoteButton.channelUp),
          ),
          DropdownMenuEntry(
            value: RemoteButton.channelDown,
            label: "Channel down",
            leadingIcon: RemoteButton.icon(RemoteButton.channelDown),
          ),
        ];
      case CommandGroupType.numeric:
        return [
          DropdownMenuEntry(
            value: RemoteButton.numberZero,
            label: "0",
            leadingIcon: RemoteButton.icon(RemoteButton.numberZero),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberOne,
            label: "1",
            leadingIcon: RemoteButton.icon(RemoteButton.numberOne),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberTwo,
            label: "2",
            leadingIcon: RemoteButton.icon(RemoteButton.numberTwo),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberThree,
            label: "3",
            leadingIcon: RemoteButton.icon(RemoteButton.numberThree),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberFour,
            label: "4",
            leadingIcon: RemoteButton.icon(RemoteButton.numberFour),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberFive,
            label: "5",
            leadingIcon: RemoteButton.icon(RemoteButton.numberFive),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberSix,
            label: "6",
            leadingIcon: RemoteButton.icon(RemoteButton.numberSix),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberSeven,
            label: "7",
            leadingIcon: RemoteButton.icon(RemoteButton.numberSeven),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberEight,
            label: "8",
            leadingIcon: RemoteButton.icon(RemoteButton.numberEight),
          ),
          DropdownMenuEntry(
            value: RemoteButton.numberNine,
            label: "9",
            leadingIcon: RemoteButton.icon(RemoteButton.numberNine),
          ),
        ];
      case CommandGroupType.input:
        return [
          DropdownMenuEntry(
            value: RemoteButton.other,
            label: "Other",
            leadingIcon: RemoteButton.icon(RemoteButton.other),
          ),
        ];
      case CommandGroupType.coloredButtons:
        return [
          DropdownMenuEntry(
            value: RemoteButton.green,
            label: "Green",
            leadingIcon: RemoteButton.icon(RemoteButton.green),
          ),
          DropdownMenuEntry(
            value: RemoteButton.red,
            label: "Red",
            leadingIcon: RemoteButton.icon(RemoteButton.red),
          ),
          DropdownMenuEntry(
            value: RemoteButton.blue,
            label: "Blue",
            leadingIcon: RemoteButton.icon(RemoteButton.blue),
          ),
          DropdownMenuEntry(
            value: RemoteButton.yellow,
            label: "Yellow",
            leadingIcon: RemoteButton.icon(RemoteButton.yellow),
          ),
        ];
      case CommandGroupType.other:
        return [
          DropdownMenuEntry(
            value: RemoteButton.brightnessUp,
            label: "Brightness up",
            leadingIcon: RemoteButton.icon(RemoteButton.brightnessUp),
          ),
          DropdownMenuEntry(
            value: RemoteButton.brightnessDown,
            label: "Brightness down",
            leadingIcon: RemoteButton.icon(RemoteButton.brightnessDown),
          ),
          DropdownMenuEntry(
            value: RemoteButton.turnOn,
            label: "Turn on",
            leadingIcon: RemoteButton.icon(RemoteButton.turnOn),
          ),
          DropdownMenuEntry(
            value: RemoteButton.turnOff,
            label: "Turn off",
            leadingIcon: RemoteButton.icon(RemoteButton.turnOff),
          ),
          DropdownMenuEntry(
            value: RemoteButton.other,
            label: "Other",
            leadingIcon: RemoteButton.icon(RemoteButton.other),
          ),
        ];
    }
  }
}