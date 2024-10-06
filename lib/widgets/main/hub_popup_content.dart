import 'package:codegopay/widgets/custom_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant_string/User.dart';
import '../../utils/assets.dart';
import '../../utils/input_fields/custom_color.dart';
import '../buttons/custom_icon_button_widget.dart';
import 'hub_container_widget.dart';

class HubPopupContent extends StatefulWidget {
  const HubPopupContent({super.key});

  @override
  _HubPopupContentState createState() => _HubPopupContentState();
}

class _HubPopupContentState extends State<HubPopupContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // Delay the animation of the close button
    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ModalRoute.of(context)!.animation!,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Start from below the screen
            end: Offset.zero, // End at the original position
          ).animate(CurvedAnimation(
            parent: ModalRoute.of(context)!.animation!,
            curve: Curves.easeInOut,
          )),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: BoxDecoration(
              color: CustomColor.scaffoldBg,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "HUB",
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: CustomColor.black,
                            ),
                          ),
                          Container(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1,
                        ),
                        children: [
                          HubContainerWidget(
                            title: "Home",
                            imagePath: StaticAssets.home,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'dashboard', (route) => false);
                            },
                          ),
                          if (User.hidepage == 0)
                            HubContainerWidget(
                              title: "Currency",
                              imagePath: StaticAssets.currencyArrow,
                              isHubContainerBorderColor: false,
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, 'cryptoScreen', (route) => false);
                              },
                            ),
                          if (User.hidepage == 0)
                            HubContainerWidget(
                              title: "Invest",
                              imagePath: StaticAssets.investment,
                              isHubContainerBorderColor: false,
                              onTap: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    'investmentScreen', (route) => false);
                              },
                            ),
                          HubContainerWidget(
                            title: "Send",
                            imagePath: StaticAssets.send,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'beneficiaryListScreen', (route) => false);
                            },
                          ),
                          HubContainerWidget(
                            title: "Cards",
                            imagePath: StaticAssets.cards,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'cardScreen', (route) => false);
                            },
                          ),
                          HubContainerWidget(
                            title: "Gift Cards",
                            imagePath: StaticAssets.giftCards,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'buyGiftCardScreen', (route) => false);
                            },
                          ),
                          HubContainerWidget(
                            title: "My Beneficiary",
                            imagePath: StaticAssets.addPeople,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'addBeneficiaryScreen', (route) => false);
                            },
                          ),

                          HubContainerWidget(
                            title: "My Profile",
                            imagePath: StaticAssets.addPeople,
                            isHubContainerBorderColor: false,
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  'profileScreen', (route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: CustomColor.primaryColor,
                        ),
                        child: CustomImageWidget(
                          imagePath: StaticAssets.close,
                          imageType: 'svg',
                          height: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
