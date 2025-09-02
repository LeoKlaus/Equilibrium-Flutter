import 'package:json_annotation/json_annotation.dart';

enum RemoteButton {
  // Power
  @JsonValue("power_toggle") powerToggle,
  @JsonValue("power_off") powerOff,
  @JsonValue("power_on") powerOn,
  // Volume
  @JsonValue("volume_up") volumeUp,
  @JsonValue("volume_down") volumeDown,
  @JsonValue("mute") mute,
  // Navigation
  @JsonValue("direction_up") directionUp,
  @JsonValue("direction_down") directionDown,
  @JsonValue("direction_left") directionLeft,
  @JsonValue("direction_right") directionRight,
  @JsonValue("select") select,
  @JsonValue("guide") guide,
  @JsonValue("info") info,
  @JsonValue("back") back,
  @JsonValue("menu") menu,
  @JsonValue("home") home,
  @JsonValue("exit") exit,
  // Transport
  @JsonValue("play") play,
  @JsonValue("pause") pause,
  @JsonValue("playpause") playpause,
  @JsonValue("stop") stop,
  @JsonValue("fast_forward") fastForward,
  @JsonValue("rewind") rewind,
  @JsonValue("next_track") nextTrack,
  @JsonValue("previous_track") previousTrack,
  @JsonValue("record") record,
  @JsonValue("channel_up") channelUp,
  @JsonValue("channel_down") channelDown,
  // Colored buttons
  @JsonValue("green") green,
  @JsonValue("red") red,
  @JsonValue("blue") blue,
  @JsonValue("yellow") yellow,
  // Numbers)
  @JsonValue("number_zero") numberZero,
  @JsonValue("number_one") numberOne,
  @JsonValue("number_two") numberTwo,
  @JsonValue("number_three") numberThree,
  @JsonValue("number_four") numberFour,
  @JsonValue("number_five") numberFive,
  @JsonValue("number_six") numberSix,
  @JsonValue("number_seven") numberSeven,
  @JsonValue("number_eight") numberEight,
  @JsonValue("number_nine") numberNine,
  // Integration
  @JsonValue("brightness_up") brightnessUp,
  @JsonValue("brightness_down") brightnessDown,
  @JsonValue("turn_on") turnOn,
  @JsonValue("turn_off") turnOff,
  // Fallback
  @JsonValue("other") other
}



