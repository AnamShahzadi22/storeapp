import 'package:flutter/material.dart';
import 'package:store_app/config/colors/colors.dart';
import 'package:store_app/services/splash/splash_services.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SplashService(context).startTimer();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: linearGradient
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Text(
                  "My Store",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 110.0),
                child: Column(
                  children: [
                    Text(
                      "Välkommen",
                      style: GoogleFonts.poppins(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: whiteColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Hos oss kan du boka tid hos nästan alla\n"
                          "Sveriges salonger och mottagningar. Boka\n"
                          "frisör, massage, skönhetsbehandlingar,\n"
                          "friskvård och mycket mer.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 12.0,
                        color: whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}