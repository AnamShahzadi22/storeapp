import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:store_app/config/colors/colors.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          'Mitt konto',
          style: GoogleFonts.playfairDisplay(
              color: blackColor,
              fontSize: 24,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: whiteColor,
        elevation: 0,
        iconTheme: IconThemeData(color: blackColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anam Shahzadi',
                        style: GoogleFonts.poppins(
                          color: whiteColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'anam@gmail.com',
                        style: GoogleFonts.poppins(color: white54Color,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '07XXXXXXXX',
                        style: GoogleFonts.poppins(color: white54Color,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Kontoinställningar',
                style: GoogleFonts.poppins(color: blackColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,),),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Mina betalmetoder',
                style: GoogleFonts.poppins(color: blackColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,),),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.support),
              title: Text('Support', style: GoogleFonts.poppins(color: blackColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,),),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}