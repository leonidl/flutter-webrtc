import 'dart:async';
import 'package:flutter/services.dart';

import 'rtc_peerconnection.dart';
import 'media_stream.dart';
import 'utils.dart';

Future<RTCPeerConnection> createPeerConnection(
    Map<String, dynamic> configuration,
    Map<String, dynamic> constraints) async {
  MethodChannel _channel = WebRTC.methodChannel();

  Map<String, dynamic> defaultConstraints = {
    "mandatory": {},
    "optional": [
      {"DtlsSrtpKeyAgreement": true},
    ],
  };

  final Map<dynamic, dynamic> response = await _channel.invokeMethod(
    'createPeerConnection',
    <String, dynamic>{
      'configuration': configuration,
      'constraints': (constraints == null || constraints.length == 0)
          ? defaultConstraints
          : constraints
    },
  );

  return new RTCPeerConnection(response['peerConnectionId'], configuration);
}

Future<MediaStream> createLocalMediaStream(String label) async {
  MethodChannel _channel = WebRTC.methodChannel();

  final Map<dynamic, dynamic> response = await _channel.invokeMethod(
    'createLocalMediaStream'
  );

  return new MediaStream(response['streamId'], label);
}
