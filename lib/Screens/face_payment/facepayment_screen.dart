// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'dart:async';
// import 'package:flutter_face_api/face_api.dart' as Regula;
//
// class FaceapiScreen extends StatefulWidget {
//   @override
//   _FaceapiScreenState createState() => _FaceapiScreenState();
// }
//
// class _FaceapiScreenState extends State<FaceapiScreen> {
//   var image1 = Regula.MatchFacesImage();
//   var image2 = Regula.MatchFacesImage();
//   var img1 = Image.asset('assets/images/portrait.png');
//   var img2 = Image.asset('assets/images/portrait.png');
//   String _similarity = "nil";
//   String _liveness = "nil";
//
//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//     const EventChannel('flutter_face_api/event/video_encoder_completion')
//         .receiveBroadcastStream()
//         .listen((event) {
//       var completion =
//           Regula.VideoEncoderCompletion.fromJson(json.decode(event))!;
//       debugPrint("VideoEncoderCompletion:");
//       debugPrint("    success:  ${completion.success}");
//       debugPrint("    transactionId:  ${completion.transactionId}");
//     });
//     const EventChannel('flutter_face_api/event/onCustomButtonTappedEvent')
//         .receiveBroadcastStream()
//         .listen((event) {
//       debugPrint("Pressed button with id: $event");
//     });
//     const EventChannel('flutter_face_api/event/livenessNotification')
//         .receiveBroadcastStream()
//         .listen((event) {
//       var notification =
//           Regula.LivenessNotification.fromJson(json.decode(event));
//       debugPrint("LivenessProcessStatus: ${notification!.status}");
//     });
//   }
//
//   Future<void> initPlatformState() async {
//     Regula.FaceSDK.init().then((json) {
//       var response = jsonDecode(json);
//       if (!response["success"]) {
//         debugPrint("Init failed: ");
//         debugPrint(json);
//       }
//     });
//   }
//
//   showAlertDialog(BuildContext context, bool first) => showDialog(
//       context: context,
//       builder: (BuildContext context) =>
//           AlertDialog(title: const Text("Select option"), actions: [
//             // ignore: deprecated_member_use
//             TextButton(
//                 child: const Text("Use camera"),
//                 onPressed: () {
//                   Regula.FaceSDK.presentFaceCaptureActivity().then((result) {
//                     var response = Regula.FaceCaptureResponse.fromJson(
//                         json.decode(result))!;
//                     if (response.image != null &&
//                         response.image!.bitmap != null) {
//                       setImage(
//                           first,
//                           base64Decode(
//                               response.image!.bitmap!.replaceAll("\n", "")),
//                           Regula.ImageType.LIVE);
//                     }
//                   });
//                   Navigator.pop(context);
//                 })
//           ]));
//
//   setImage(bool first, Uint8List? imageFile, int type) {
//     if (imageFile == null) return;
//     setState(() => _similarity = "nil");
//     if (first) {
//       image1.bitmap = base64Encode(imageFile);
//       image1.imageType = type;
//       setState(() {
//         img1 = Image.memory(imageFile);
//
//         _liveness = "nil";
//       });
//     } else {
//       image2.bitmap = base64Encode(imageFile);
//       image2.imageType = type;
//       setState(() => img2 = Image.memory(imageFile));
//     }
//   }
//
//   clearResults() {
//     setState(() {
//       img1 = Image.asset('assets/images/portrait.png');
//       img2 = Image.asset('assets/images/portrait.png');
//       _similarity = "nil";
//       _liveness = "nil";
//     });
//     image1 = Regula.MatchFacesImage();
//     image2 = Regula.MatchFacesImage();
//   }
//
//   matchFaces() {
//     if (image1.bitmap == null ||
//         image1.bitmap == "" ||
//         image2.bitmap == null ||
//         image2.bitmap == "") return;
//     setState(() => _similarity = "Processing...");
//     var request = Regula.MatchFacesRequest();
//     request.images = [image1, image2];
//     Regula.FaceSDK.matchFaces(jsonEncode(request)).then((value) {
//       var response = Regula.MatchFacesResponse.fromJson(json.decode(value));
//       Regula.FaceSDK.matchFacesSimilarityThresholdSplit(
//               jsonEncode(response!.results), 0.75)
//           .then((str) {
//         var split = Regula.MatchFacesSimilarityThresholdSplit.fromJson(
//             json.decode(str));
//         setState(() => _similarity = split!.matchedFaces.length > 0
//             ? ("${(split.matchedFaces[0]!.similarity! * 100).toStringAsFixed(2)}%")
//             : "error");
//       });
//     });
//   }
//
//   liveness() => Regula.FaceSDK.startLiveness().then((value) {
//         var result = Regula.LivenessResponse.fromJson(json.decode(value));
//         if (result!.bitmap == null) return;
//         setImage(true, base64Decode(result.bitmap!.replaceAll("\n", "")),
//             Regula.ImageType.LIVE);
//
//         if (result.liveness == Regula.LivenessStatus.PASSED) {}
//
//         setState(() => _liveness =
//             result.liveness == Regula.LivenessStatus.PASSED
//                 ? "passed"
//                 : "unknown");
//       });
//
//   Widget createButton(String text, VoidCallback onPress) => SizedBox(
//         // ignore: deprecated_member_use
//         width: 250,
//         // ignore: deprecated_member_use
//         child: TextButton(
//             style: ButtonStyle(
//               foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               backgroundColor: MaterialStateProperty.all<Color>(Colors.black12),
//             ),
//             onPressed: onPress,
//             child: Text(text)),
//       );
//
//   Widget createImage(image, VoidCallback onPress) => Material(
//           child: InkWell(
//         onTap: onPress,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(20.0),
//           child: Image(height: 150, width: 150, image: image),
//         ),
//       ));
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Container(
//             margin: const EdgeInsets.fromLTRB(0, 0, 0, 100),
//             width: double.infinity,
//             child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(margin: const EdgeInsets.fromLTRB(0, 0, 0, 15)),
//                   createButton("use Your face", () => liveness()),
//                   Container(
//                       margin: const EdgeInsets.fromLTRB(0, 15, 0, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text("Similarity: $_similarity",
//                               style: const TextStyle(fontSize: 18)),
//                           Container(
//                               margin: const EdgeInsets.fromLTRB(20, 0, 0, 0)),
//                           Text("Liveness: $_liveness",
//                               style: const TextStyle(fontSize: 18))
//                         ],
//                       ))
//                 ])),
//       );
// }
