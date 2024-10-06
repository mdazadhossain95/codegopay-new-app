import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'dart:io';

import '../../../../utils/assets.dart';
import '../../../../utils/input_fields/custom_color.dart';
import '../../../../utils/strings.dart';
import '../../../../widgets/buttons/primary_button_widget.dart';
import '../../../../widgets/custom_image_widget.dart';
import '../image_preview/address_preview_screen.dart';

class AddressProofScreen extends StatefulWidget {
  const AddressProofScreen({super.key});

  @override
  State<AddressProofScreen> createState() => _AddressProofScreenState();
}

class _AddressProofScreenState extends State<AddressProofScreen> {
  final String _selectedCard = 'ID Card'; // Default selection
  late CameraController _controller;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  // ignore: unused_field
  late Future<void> _initializeControllerFuture;

  File? idCapture; // Variable to store the captured ID image file

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldBg,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    Strings.addressProofTitle,
                    style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.black),
                  ),
                  Text(
                    Strings.addressProofSubTitle1,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: CustomColor.subtitleTextColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        _uploadProofIdentity(context, _selectedCard),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  PrimaryButtonWidget(
                    onPressed: () {
                      _takePicture(context);
                    },
                    buttonText: 'Continue',
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black45,
              child: Center(
                child: Text(
                  "Processing...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: CustomColor.subtitleTextColor),
                ),
              ),
            ),
        ],
      ),
    );
  }

  _uploadProofIdentity(BuildContext context, String isPassport) {
    return InkWell(
      onTap: () {},
      child: Center(
          child: DottedBorder(
              child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageWidget(
                              imagePath: StaticAssets.addressProof,
                              imageType: "svg",
                              height: 24,
                            ),
                            Text(
                              Strings.uploadAddressProof,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                color: CustomColor.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(
                                Strings.uploadAddressProofSubTitle,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  color: CustomColor.subtitleTextColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )))),
    );
  }

  Future<void> _takePicture(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        print('Captured image path: ${image.path}');
        File imageFile = File(image.path);

        try {
          // Read the image bytes
          final bytes = await imageFile.readAsBytes();
          print("Read image bytes successfully: ${bytes.length} bytes");

          // Decode the image
          final decodedImage = img.decodeImage(bytes);
          if (decodedImage == null) {
            print('Failed to decode image');
            return;
          }
          print(
              "Decoded image successfully: ${decodedImage.width}x${decodedImage.height}");

          // Encode the image to PNG format
          final pngBytes = img.encodePng(decodedImage);
          print("Encoded image to PNG successfully: ${pngBytes.length} bytes");

          // Save the PNG image
          final appDir = await getApplicationDocumentsDirectory();
          final fileName = '${DateTime.now().toIso8601String()}_image.png';
          final savedImage = File('${appDir.path}/$fileName');
          await savedImage.writeAsBytes(Uint8List.fromList(pngBytes));
          print("Saved image to: ${savedImage.path}");

          print(
              savedImage.writeAsBytes(Uint8List.fromList(pngBytes)).toString());

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddressPreviewScreen(imageFile: savedImage),
            ),
          );
        } catch (e) {
          print('Error during image processing: $e');
        }
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error capturing image: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = CustomColor.primaryInputHintBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Dotted border pattern
    const double dashWidth = 5;
    const double dashSpace = 5;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    PathMetrics pathMetrics = path.computeMetrics();
    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        Path dashPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(dashPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class DottedBorder extends StatelessWidget {
  final Widget child;

  const DottedBorder({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DottedBorderPainter(),
      child: child,
    );
  }
}
